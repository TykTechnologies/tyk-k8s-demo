source "src/deployments/operator/main.safe.sh";
source "src/deployments/operator-httpbin/main.safe.sh";

logger "$INFO" "installing keycloak DCR realm...";

sed "s/replace_keycloak/$keycloakName/g" src/deployments/keycloak-dcr/realm.yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "installed keycloak DCR realm...";

#eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI1ODY2YjFlNS0wNjA5LTQ0NTctODMwNC03MjNhNjNkNWY0MzIifQ.eyJleHAiOi0xNzUyMzE1MzA1LCJpYXQiOjE2Nzg3MzgzOTEsImp0aSI6IjAzY2E5NDQ5LTRiNjctNDk3NS04N2Y4LTkxN2JhM2Q1OGJhNiIsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcwMDAvcmVhbG1zL2tleWNsb2FrLWRjciIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjcwMDAvcmVhbG1zL2tleWNsb2FrLWRjciIsInR5cCI6IkluaXRpYWxBY2Nlc3NUb2tlbiJ9.PCilv9xavZNsN8HR5Fl6wc7BfUbFkF6osD6p8E7v1lU
#03ca9449-4b67-4975-87f8-917ba3d58ba6
