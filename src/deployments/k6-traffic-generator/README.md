## K6 Traffic Generator
This deployment generates some traffic through Tyk to demo analytics.

### Requirements
This deployment requires the installation of the `tyk-operator` and the `httpbin` API. Both of which can be deployed using the following deployment options:
- [operator](../operator)
- [operator-httpbin](../operator-httpbin)

### Jobs
The generator jobs are run using the [k6-operator](https://github.com/grafana/k6-operator) which does not terminate jobs once they are finished. There is a hack in the code to overcome this but if that fails you can run the following to delete those jobs when completed.

```
load_test_name=k6-load-test-1671763896
namespace=tyk
sed "s/load_test_name/$load_test_name/g" src/deployments/k6-traffic-generator/k6-load-test-template.yaml | \
	kubectl delete -n "$namespace" -f -
```
