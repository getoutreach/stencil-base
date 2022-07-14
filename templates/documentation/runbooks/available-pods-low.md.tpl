{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} Available Pods Low 🧊 -->

# {{ camelcase .Config.Name }} Available Pods Low

This alert triggers when most of the {{ camelcase .Config.Name }} pods have crashed or were otherwise terminated. During normal operation and with deployments, it is expected that the pods will cycle regularly, however the the Kubernetes disruption budget should ensure that there is always a pool of pods available to service requests. When this alert triggers, it is a sign that there are no longer enough pods running to ensure consistent service and if any more go down, an outage may occur.

If this alert is accompanied by [Pod Restarts](/documentation/runbooks/pod_restarts.md) alerts, it is possible that there is a critical issue causing the {{ camelcase .Config.Name }} service to repeatedly crash and immediate attention is required.

<!--- Block(availablePodsLowOverview) -->
{{ file.Block "availablePodsLowOverview" }}
<!--- EndBlock(availablePodsLowOverview) -->

## Investigation

### Kubernetes Pod State

Below are steps to follow to investigate the state of the Kubernetes pods as well as look for potential reasons the number of running pods is low.

List the pods in the bento that the alert fired in for this service:

```shell
kubectl -n {{ .Config.Name }}--<bento> get pods
```

It's likely that some number of service pods are in an unhealthy state, describe them:

```shell
kubectl -n {{ .Config.Name }}--<bento> describe pod <pod name>
```

Look at the events and last known state when describing the pods, one of these areas should lead in the
correct direction of the source of the problem. It may also be a useful exercise to peek at the deployment:

```shell
kubectl -n {{ .Config.Name }}--<bento> describe deployment {{ .Config.Name }}
```

<!--- Block(availablePodsLowPodState) -->
{{ file.Block "availablePodsLowPodState" }}
<!--- EndBlock(availablePodsLowPodState) -->

### Datadog Dashboard and Logs

The {{ .Config.Name }} service has a dashboard in Datadog: https://app.datadoghq.com/dashboard/i6z-jcn-azh/terraform-{{ .Config.Name }}

Look for any anomalies in the dashboard.

{{ camelcase .Config.Name }} logs are available via a search: https://app.datadoghq.com/logs/livetail?query=service%3A{{ .Config.Name }}%20environment%3Aproduction%20status%3Aerror&index=main&from_ts=1652033594145&to_ts=1652206394145&live=true. Modify the search parameters to match the bento and environment the alert was generated from.

Look for signs of issues or abnormal behavior.

<!--- Block(availablePodsLowDatadog) -->
{{ file.Block "availablePodsLowDatadog" }}
<!--- EndBlock(availablePodsLowDatadog) -->

### Check Komodor for Pod State and Logs

Often times the historical state and logs are not easily accessible from within the running cluster. If the logs from the crashed pod are not readily retrievable they may be archived in Komodor.

Start by navigating to the {{ camelcase .Config.Name }} service list in Komodor: https://app.komodor.com/main/services?textFilter={{ .Config.Name }}&filters=%7B%7D&tabType=service

From the main service list page select the bento that is alerting and view the pod status. You will likely want to inspect the pod details and logs:

Once in the pod details page look for events or logs (both current and previous) that may provide clues to the root cause of the low number of running pods.

<!--- Block(availablePodsLowKomodor) -->
{{ file.Block "availablePodsLowKomodor" }}
<!--- EndBlock(availablePodsLowKomodor) -->

<!--- Block(availablePodsInvestigation) -->
{{ file.Block "availablePodsInvestigation" }}
<!--- EndBlock(availablePodsInvestigation) -->

## Resolution

<!--- Block(availablePodsLowResolution) -->
{{ file.Block "availablePodsLowResolution" }}
<!--- EndBlock(availablePodsLowResolution) -->

<!--- Block(availablePodsLowExtra) -->
{{ file.Block "availablePodsLowExtra" }}
<!--- EndBlock(availablePodsLowExtra) -->
