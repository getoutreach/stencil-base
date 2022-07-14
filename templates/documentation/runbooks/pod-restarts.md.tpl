{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} Pod Restarts 🧊 -->

# {{ camelcase .Config.Name }} Pod Restarts > \<threshold\> last 30m

If a service’s pod is being restarted, it means the resource usage is not configured or the service itself is behaving in an unpredictable manner.

Often times the service will be restarted sporadically and no error is logged. As long as pods are spun up rapidly and this alert is not followed by a [Available Pods Low](/documentation/runbooks/available_pods_low.md) alert then it is likely that the event is not an emergency and does not need urgent attention. If the pod restarts are sustained and accompanied by a pods low alert then it is likely that there is an issue with {{ camelcase .Config.Name }} that will seriously degrade or bring down the service and urgent attention is required.

Note that this alert is often correlated with the [Available Pods Low](/documentation/runbooks/available_pods_low.md) alert.

## Investigation

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

<!--- Block(podRestartsPodState) -->
{{ file.Block "podRestartsPodState" }}
<!--- EndBlock(podRestartsPodState) -->

### Datadog Dashboard and Logs

The {{ .Config.Name }} service has a [Datadog dashboard]({{ $dashboard }}). 

Look for any anomalies in the dashboard.

To look for signs of issues or abnormal behavior in the logs, [navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in.

Look at the {{ camelcase .Config.Name }} logs for a log line like the following:

```
[Triggered on {kube_namespace:{ .Config.Name }}--<bento>}] { .Config.Name }} Pod Restarts > 0 last 30m
```

Modify the `<bento>` value to match the bento the issue is alerting from. Once you find that line, then look at the few minutes before that for logs that give any indication of unpredictable behavior from the service itself.

<!--- Block(podRestartsDatadog) -->
{{ file.Block "podRestartsDatadog" }}
<!--- EndBlock(podRestartsDatadog) -->

### Check Komodor for Pod State and Logs

Often times the historical state and logs are not easily accessible from within the running cluster. If the logs from the crashed pod are not readily retrievable they may be archived in Komodor.

Start by navigating to the {{ camelcase .Config.Name }} [service list in Komodor](https://app.komodor.com/main/services?textFilter={{ .Config.Name }}&filters=%7B%7D&tabType=service)

From the main service list page select the bento that is alerting and view the pod status. You will likely want to inspect the pod details and logs:

Once in the pod details page look for events or logs (both current and previous) that may provide clues to the root cause of the low number of running pods:

<!--- Block(podRestartsKomodor) -->
{{ file.Block "podRestartsKomodor" }}
<!--- EndBlock(podRestartsKomodor) -->

<!--- Block(podRestartsInvestigation) -->
{{ file.Block "podRestartsInvestigation" }}
<!--- EndBlock(podRestartsInvestigation) -->

## Resolution

<!--- Block(podRestartsResolution) -->
{{ file.Block "podRestartsResolution" }}
<!--- EndBlock(podRestartsResolution) -->


<!--- Block(podRestarts) -->
{{ file.Block "podRestarts" }}
<!--- EndBlock(podRestarts) -->
