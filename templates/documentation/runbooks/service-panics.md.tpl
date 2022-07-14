{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} Service Panics 🧊 -->

# {{ camelcase .Config.Name }} Service Panics

## Investigation

### Datadog Dashboard and Logs

The {{ .Config.Name }} service has a [Datadog dashboard]({{ $dashboard }}). 

Look for any anomalies in the dashboard.

[Navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in. These logs
should provide an idea as to what could be the root cause of the panics.

<!--- Block(servicePanicsDatadog) -->
{{ file.Block "servicePanicsDatadog" }}
<!--- EndBlock(servicePanicsDatadog) -->

### Kubernetes Pod State

List the pods in the bento that the alert fired in for this service:

```shell
kubectl -n {{ .Config.Name }}--<bento> get pods
```

It's likely that some number of service pods have a high number of restarts, describe them:

```shell
kubectl -n {{ .Config.Name }}--<bento> describe pod <pod name>
```

Look at the events and last known state when describing the pods, one of these areas should lead in the
correct direction of the source of the problem. It may also be a useful exercise to peek at the deployment:

```shell
kubectl -n {{ .Config.Name }}--<bento> describe deployment {{ .Config.Name }}
```

If a pod recently crashed the previous logs may still be available and viewable via:

```shell
kubectl -n {{ .Config.Name }}--<bento> logs --previous <pod name>
```

where `<pod name>` is the name of the pod that just recently started up after the crash

<!--- Block(servicePanicsPodState) -->
{{ file.Block "servicePanicsPodState" }}
<!--- EndBlock(servicePanicsPodState) -->

### Check Komodor for Pod State and Logs

Often times the historical state and logs are not easily accessible from within the running cluster. If the logs from the crashed pod are not readily retrievable they may be archived in Komodor.

Start by navigating to the {{ camelcase .Config.Name }} [service list in Komodor](https://app.komodor.com/main/services?textFilter={{ .Config.Name }}&filters=%7B%7D&tabType=service)

From the main service list page select the bento that is alerting and view the pod status. You will likely want to inspect the pod details and logs:

Once in the pod details page look for events or logs (both current and previous) that may provide clues to the root cause of the low number of running pods:

<!--- Block(servicePanicsKomodor) -->
{{ file.Block "servicePanicsKomodor" }}
<!--- EndBlock(servicePanicsKomodor) -->

<!--- Block(servicePanicsInvestigation) -->
{{ file.Block "servicePanicsInvestigation" }}
<!--- EndBlock(servicePanicsInvestigation) -->

# Resolution

<!--- Block(servicePanicsResolution) -->
{{ file.Block "servicePanicsResolution" }}
<!--- EndBlock(servicePanicsResolution) -->

<!--- Block(servicePanics) -->
{{ file.Block "servicePanics" }}
<!--- EndBlock(servicePanics) -->
