# Default OPA rules
package dashboard_users
default request_intent = "write"
request_intent = "read" { input.request.method == "GET" }
request_intent = "read" { input.request.method == "HEAD" }
request_intent = "delete" { input.request.method == "DELETE" }
# Set of rules to define which permission is required for a given request intent.
# read intent requires, at a minimum, the "read" permission
intent_match("read", "read")
intent_match("read", "write")
intent_match("read", "admin")
# write intent requires either the "write" or "admin" permission
intent_match("write", "write")
intent_match("write", "admin")
# delete intent requires either the "write" or "admin permission
intent_match("delete", "write")
intent_match("delete", "admin")
# Helper to check if the user has "admin" permissions
default is_admin = false
is_admin {
    input.user.user_permissions["IsAdmin"] == "admin"
}
# Check if the request path matches any of the known permissions.
# input.permissions is an object passed from the Tyk Dashboard containing mapping between user permissions (“read”, “write” and “deny”) and the endpoint associated with the permission.
# (eg. If “deny” is the permission for Analytics, it means the user would be denied the ability to make a request to ‘/api/usage’.)
#
# Example object:
#  "permissions": [
#        {
#            "permission": "analytics",
#            "rx": "\\/api\\/usage"
#        },
#        {
#            "permission": "analytics",
#            "rx": "\\/api\\/uptime"
#        }
#        ....
#  ]
#
# The input.permissions object can be extended with additional permissions (eg. you could create a permission called ‘Monitoring’ which gives “read” access to the analytics API ‘/analytics’).
# This is can be achieved inside this script using the array.concat function.
request_permission[role] {
	perm := input.permissions[_]
	regex.match(perm.rx, input.request.path)
	role := perm.permission
}
# --------- Start "deny" rules -----------
# A deny object contains a detailed reason behind the denial.
default allow = false
allow { count(deny) == 0 }
deny["User is not active"] {
	not input.user.active
}
# If a request to an endpoint does not match any defined permissions, the request will be denied.
deny[x] {
	count(request_permission) == 0
	x := sprintf("This action is unknown. You do not have permission to access '%v'.", [input.request.path])
}
deny[x] {
	perm := request_permission[_]
	perm != "ResetPassword"
	not is_admin
	not input.user.user_permissions[perm]
	x := sprintf("You do not have permission to access '%v'.", [input.request.path])
}
# Deny requests for non-admins if the intent does not match or does not exist.
deny[x] {
	perm := request_permission[_]
	not is_admin
	not intent_match(request_intent, input.user.user_permissions[perm])
	x := sprintf("You do not have permission to carry out '%v' operation.", [request_intent, input.request.path])
}
# If the "deny" rule is found, deny the operation for admins
deny[x] {
	perm := request_permission[_]
	is_admin
	input.user.user_permissions[perm] == "deny"
	x := sprintf("You do not have permission to carry out '%v' operation.", [request_intent, input.request.path])
}
# Do not allow users (excluding admin users) to reset the password of another user.
deny[x] {
	request_permission[_] = "ResetPassword"
	not is_admin
	user_id := split(input.request.path, "/")[3]
	user_id != input.user.id
	x := sprintf("You do not have permission to reset the password for other users.", [user_id])
}
# Do not allow admin users to reset passwords if it is not allowed in the global config
deny[x] {
	request_permission[_] == "ResetPassword"
	is_admin
	not input.config.security.allow_admin_reset_password
	not input.user.user_permissions["ResetPassword"]
	x := "You do not have permission to reset the password for other users. As an admin user, this permission can be modified using OPA rules."
}
# --------- End "deny" rules ----------
# --------- Start "custom" rules -----------
deny[x] {
	request_permission[_] == "apis"
	request_intent = "write"
	input.request.body.api_definition.use_go_plugin_auth == true
	x := "You are not permitted you use Custom Go Plugin Authetication."
}

apply_group_ownership = payload {
  input.request.body["api_definition"] != null
  input.user.group_id != ""
  payload := {"user_group_owners": [input.user.group_id]}
} else = payload {
  endswith(input.request.path, "/access")
  input.user.group_id != ""
  payload := {"userGroupIds": [input.user.group_id]}
} else = payload {
  payload := {}
}

patch_request[x] {
  request_permission[_] == "apis"
  request_intent == "write"
  x := apply_group_ownership
}
# --------- End "custom" rules ----------
