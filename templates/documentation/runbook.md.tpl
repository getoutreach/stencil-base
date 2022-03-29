{{- /* Only render markdown if forced, or if we're a service */}}
{{- if (not (or (stencil.Arg "forceRenderMarkdown") (eq (stencil.ApplyTemplate "isService") "true"))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- $http := (has "http" (stencil.Arg "type")) }}
{{- $grpc := (has "grpc" (stencil.Arg "type")) }}
{{- $dashboard := stencil.Arg "opslevel.datadogDashboards.mainLink" }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Runbook 🧊 -->

# {{ .Config.Name }} Runbook

## General Debugging

### Kubernetes Resources

To view all of the kubernetes resources created by {{ .Config.Name }}, use the following command after
switching into the appropriate context using `orc context`:

```shell
kubectl -n {{ .Config.Name }}--<bento> get all
```

<!--- Block(generalDebugging) -->
{{ file.Block "generalDebugging" }}
<!--- EndBlock(generalDebugging) -->

## Debugging Specific Alerts

### {{ camelcase .Config.Name }} Available Pods Low

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

<!--- Block(availablePodsLow) -->
{{ file.Block "availablePodsLow" }}
<!--- EndBlock(availablePodsLow) -->

{{- if $grpc }}
### {{ camelcase .Config.Name }} gRPC Success Rate Low

This indicates that there are gRPC requests that are returning unintended server errors.

[Navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in. These logs
should provide an idea as to what could be the root cause of gRPC calls resulting in server-level errors.

<!--- Block(grpcSuccessRateLow) -->
{{ file.Block "grpcSuccessRateLow" }}
<!--- EndBlock(grpcSuccessRateLow) -->

### {{ camelcase .Config.Name }} gRPC Latency High

This indicates that there are gRPC requests that are taking a long time to complete.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces should provide an idea as to what could be the root cause of the latency.

<!--- Block(grpcLatencyHigh) -->
{{ file.Block "grpcLatencyHigh" }}
<!--- EndBlock(grpcLatencyHigh) -->
{{- end }}

{{- if $http }}
### {{ camelcase .Config.Name }} HTTP Success Rate Low

This indicates that there are HTTP requests that are returning unintended server errors.

[Navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in. These logs
should provide an idea as to what could be the root cause of HTTP calls resulting in server-level errors.

<!--- Block(httpSuccessRateLow) -->
{{ file.Block "httpSuccessRateLow" }}
<!--- EndBlock(httpSuccessRateLow) -->

### {{ camelcase .Config.Name }} HTTP Latency High

This indicates that there are HTTP requests that are taking a long time to complete.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces should provide an idea as to what could be the root cause of the latency.

<!--- Block(httpLatencyHigh) -->
{{ file.Block "httpLatencyHigh" }}
<!--- EndBlock(httpLatencyHigh) -->
{{- end }}

### {{ camelcase .Config.Name }} Pod Restarts > \<threshold\> last 30m

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

<!--- Block(podRestarts) -->
{{ file.Block "podRestarts" }}
<!--- EndBlock(podRestarts) -->

### {{ camelcase .Config.Name }} Service panics

[Navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in. These logs
should provide an idea as to what could be the root cause of the panics.

<!--- Block(servicePanics) -->
{{ file.Block "servicePanics" }}
<!--- EndBlock(servicePanics) -->

### {{ camelcase .Config.Name }} Pod CPU > \<threshold\>% of request last \<window\>m

[Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard]($dashboard) and find the "Total CPU" monitor under
the "Deployment" pane. Zero-in on a time frame where CPU spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

<!--- Block(podCPUSpike) -->
{{ file.Block "podCPUSpike" }}
<!--- EndBlock(podCPUSpike) -->

### {{ camelcase .Config.Name }} Pod Memory.\<type\> > 80% of limit last 30m

[Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard]($dashboard) and find the "Total Memory" monitor under
the "Deployment" pane. Zero-in on a time frame where memory spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

<!--- Block(podMemorySpike) -->
{{ file.Block "podMemorySpike" }}
<!--- EndBlock(podMemorySpike) -->

<!--- Block(debuggingSpecificAlerts) -->
{{ file.Block "debuggingSpecificAlerts" }}
<!--- EndBlock(debuggingSpecificAlerts) -->
