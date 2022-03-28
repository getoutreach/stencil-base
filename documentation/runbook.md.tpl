{{- /* Only render markdown if forced, or if we're a service */}}
{{- if (not (or (stencil.Arg "forceRenderMarkdown") (eq (stencil.ApplyTemplate "isService") "true")) }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- $http := (has "http" (stencil.Arg "type")) }}
{{- $grpc := (has "grpc" (stencil.Arg "type")) }}
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

Navigate to Datadog and use the `kube_namespace:{{ .Config.Name }}--<bento>` and `status:error` facets
where `<bento>` is the bento that this alert fired in. These logs should provide an idea as to what could be
the root cause of gRPC calls resulting in server-level errors.

<!--- Block(grpcSuccessRateLow) -->
{{ file.Block "grpcSuccessRateLow" }}
<!--- EndBlock(grpcSuccessRateLow) -->

### {{ camelcase .Config.Name }} gRPC Latency High

Use honeycomb to debug this alert. Better advice on how to do this is coming soon.

<!--- Block(grpcLatencyHigh) -->
{{ file.Block "grpcLatencyHigh" }}
<!--- EndBlock(grpcLatencyHigh) -->
{{- end }}

{{- if $http }}
### {{ camelcase .Config.Name }} HTTP Success Rate Low

Navigate to Datadog and use the `kube_namespace:{{ .Config.Name }}--<bento>` and `status:error` facets
where `<bento>` is the bento that this alert fired in. These logs should provide an idea as to what could be
the root cause of HTTP calls resulting in server-level errors.

<!--- Block(httpSuccessRateLow) -->
{{ file.Block "httpSuccessRateLow" }}
<!--- EndBlock(httpSuccessRateLow) -->

### {{ camelcase .Config.Name }} HTTP Latency High

Use honeycomb to debug this alert. Better advice on how to do this is coming soon.

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

Navigate to Datadog and use the `kube_namespace:{{ .Config.Name }}--<bento>` and `status:error` facets
where `<bento>` is the bento that this alert fired in. These logs should provide an idea as to what could be
the root cause of the panics.

<!--- Block(servicePanics) -->
{{ file.Block "servicePanics" }}
<!--- EndBlock(servicePanics) -->

### {{ camelcase .Config.Name }} Pod CPU > \<threshold\>% of request last \<window\>m

Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard and find the "Total CPU" monitor under
the "Deployment" pane. Zero-in on a time frame where CPU spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

<!--- Block(podCPUSpike) -->
{{ file.Block "podCPUSpike" }}
<!--- EndBlock(podCPUSpike) -->

### {{ camelcase .Config.Name }} Pod Memory.\<type\> > 80% of limit last 30m

Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard and find the "Total Memory" monitor under
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
