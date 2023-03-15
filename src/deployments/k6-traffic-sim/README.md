## K6 Traffic Simulator
This deployment generates some traffic through Tyk to demo analytics.

### Requirements
This deployment will install the `tyk-operator` and the `httpbin` API as requirements.
- [operator](../operator)
- [operator-httpbin](../operator-httpbin)

### Jobs
The generator jobs are run using the [k6-operator](https://github.com/grafana/k6-operator) which does not terminate jobs once they are finished. There is a hack in the code to overcome this but if that fails you can run the following to delete those jobs when completed.

```
test_name=k6-load-test-1671763896
namespace=tyk
sed "s/replace_test_name/$test_name/g" src/deployments/k6-traffic-sim/k6-load-test-template.yaml | \
	kubectl delete --namespace "$namespace" -f -
```
