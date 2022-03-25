{{- /* Only render markdown if forced, or if we're a service */}}
{{- if or (not (stencil.Arg "forceRenderMarkdown")) (eq (stencil.ApplyTemplate "isService") "true") }}
{{- file.Skip "project is not a service" }}
{{- end }}
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

### {{ camelcase stencil.Arg "name" }} Available Pods Low

List the pods in the bento that the alert fired in for this service:

```shell
kubectl -n {{ stencil.Arg "name" }}--<bento> get pods
```

It's likely that some number of service pods are in an unhealthy state, describe them:

```shell
kubectl -n {{ stencil.Arg "name" }}--<bento> describe pod <pod name>
```

Look at the events and last known state when describing the pods, one of these areas should lead in the
correct direction of the source of the problem. It may also be a useful exercise to peek at the deployment:

```shell
kubectl -n {{ stencil.Arg "name" }}--<bento> describe deployment {{ stencil.Arg "name" }}
```

<!--- Block(availablePodsLow) -->
{{- if .availablePodsLow }}
{{ .availablePodsLow }}
{{- end }}
<!--- EndBlock(availablePodsLow) -->

### {{ camelcase stencil.Arg "name" }} gRPC Success Rate Low

Navigate to Datadog and use the `kube_namespace:{{ stencil.Arg "name" }}--<bento>` and `status:error` facets
where `<bento>` is the bento that this alert fired in. These logs should provide an idea as to what could be
the root cause of gRPC calls resulting in server-level errors.

<!--- Block(grpcSuccessRateLow) -->
{{- if .grpcSuccessRateLow }}
{{ .grpcSuccessRateLow }}
{{- end }}
<!--- EndBlock(grpcSuccessRateLow) -->

### {{ camelcase stencil.Arg "name" }} gRPC Latency High

HONEYCOMB SCARY

<!--- Block(grpcLatencyHigh) -->
{{- if .grpcLatencyHigh }}
{{ .grpcLatencyHigh }}
{{- end }}
<!--- EndBlock(grpcLatencyHigh) -->

### {{ camelcase stencil.Arg "name" }} HTTP Success Rate Low

Navigate to Datadog and use the `kube_namespace:{{ stencil.Arg "name" }}--<bento>` and `status:error` facets
where `<bento>` is the bento that this alert fired in. These logs should provide an idea as to what could be
the root cause of HTTP calls resulting in server-level errors.

<!--- Block(httpSuccessRateLow) -->
{{- if .httpSuccessRateLow }}
{{ .httpSuccessRateLow }}
{{- end }}
<!--- EndBlock(httpSuccessRateLow) -->

### {{ camelcase stencil.Arg "name" }} HTTP Latency High

HONEYCOMB SCARY

<!--- Block(httpLatencyHigh) -->
{{- if .httpLatencyHigh }}
{{ .httpLatencyHigh }}
{{- end }}
<!--- EndBlock(httpLatencyHigh) -->

### {{ camelcase stencil.Arg "name" }} Pod Restarts > \<threshold\> last 30m

List the pods in the bento that the alert fired in for this service:

```shell
kubectl -n {{ stencil.Arg "name" }}--<bento> get pods
```

It's likely that some number of service pods have a high number of restarts, describe them:

```shell
kubectl -n {{ stencil.Arg "name" }}--<bento> describe pod <pod name>
```

Look at the events and last known state when describing the pods, one of these areas should lead in the
correct direction of the source of the problem. It may also be a useful exercise to peek at the deployment:

```shell
kubectl -n {{ stencil.Arg "name" }}--<bento> describe deployment {{ stencil.Arg "name" }}
```

<!--- Block(podRestarts) -->
{{- if .podRestarts }}
{{ .podRestarts }}
{{- end }}
<!--- EndBlock(podRestarts) -->

### {{ camelcase stencil.Arg "name" }} Service panics

Navigate to Datadog and use the `kube_namespace:{{ stencil.Arg "name" }}--<bento>` and `status:error` facets
where `<bento>` is the bento that this alert fired in. These logs should provide an idea as to what could be
the root cause of the panics.

<!--- Block(servicePanics) -->
{{- if .servicePanics }}
{{ .servicePanics }}
{{- end }}
<!--- EndBlock(servicePanics) -->

### {{ camelcase stencil.Arg "name" }} Pod CPU > \<threshold\>% of request last \<window\>m

Navigate to the `Terraform: {{ camelcase stencil.Arg "name" }}` dashboard and find the "Total CPU" monitor under
the "Deployment" pane. Zero-in on a time frame where CPU spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ stencil.Arg "name" }}--<bento>` facet.

<!--- Block(podCPUSpike) -->
{{- if .podCPUSpike }}
{{ .podCPUSpike }}
{{- end }}
<!--- EndBlock(podCPUSpike) -->

### {{ camelcase stencil.Arg "name" }} Pod Memory.\<type\> > 80% of limit last 30m

Navigate to the `Terraform: {{ camelcase stencil.Arg "name" }}` dashboard and find the "Total Memory" monitor under
the "Deployment" pane. Zero-in on a time frame where memory spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ stencil.Arg "name" }}--<bento>` facet.

<!--- Block(podMemorySpike) -->
{{- if .podMemorySpike }}
{{ .podMemorySpike }}
{{- end }}
<!--- EndBlock(podMemorySpike) -->

<!--- Block(debuggingSpecificAlerts) -->
{{ file.Block "debuggingSpecificAlerts" }}
<!--- EndBlock(debuggingSpecificAlerts) -->
