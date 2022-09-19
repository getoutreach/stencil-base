{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- $dashboard := stencil.Arg "datadogDashboards.mainLink" }}
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

<!-- <<Stencil::Block(servicePanicsDatadog)>> -->
{{ file.Block "servicePanicsDatadog" }}
<!-- <</Stencil::Block>> -->

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

<!-- <<Stencil::Block(servicePanicsPodState)>> -->
{{ file.Block "servicePanicsPodState" }}
<!-- <</Stencil::Block>> -->

### Check Komodor for Pod State and Logs

Often times the historical state and logs are not easily accessible from within the running cluster. If the logs from the crashed pod are not readily retrievable they may be archived in Komodor.

Start by navigating to the {{ camelcase .Config.Name }} [service list in Komodor](https://app.komodor.com/main/services?textFilter={{ .Config.Name }}&filters=%7B%7D&tabType=service)

From the main service list page select the bento that is alerting and view the pod status. If the list of bentos is long you can filter the bentos by namespace to shorten the list of bentos and make it easier to identify the relevant bento deployment. As a reminder, Kubernetes namespaces, by convention, are formatted like `{{ .Config.Name }}--<bento>`, where `<bento>` is the bento name.

Once in the pod details page look for events or logs (both current and previous) that may provide clues to the root cause of the low number of running pods:

<!-- <<Stencil::Block(servicePanicsKomodor)>> -->
{{ file.Block "servicePanicsKomodor" }}
<!-- <</Stencil::Block>> -->

<!-- <<Stencil::Block(servicePanicsInvestigation)>> -->
{{ file.Block "servicePanicsInvestigation" }}
<!-- <</Stencil::Block>> -->

# Resolution

<!-- <<Stencil::Block(servicePanicsResolution)>> -->
{{ file.Block "servicePanicsResolution" }}
<!-- <</Stencil::Block>> -->

<!-- <<Stencil::Block(servicePanics)>> -->
{{ file.Block "servicePanics" }}
<!-- <</Stencil::Block>> -->
