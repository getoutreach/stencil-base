{{- $grpc := (has "grpc" (stencil.Arg "serviceActivities")) }}
{{- if or (not (stencil.Arg "service")) (not $grpc) }}
{{- file.Skip "project is not a service with grpc service activity" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} gRPC Latency High 🧊 -->

# {{ camelcase .Config.Name }} gRPC Latency High

This indicates that there are gRPC requests that are taking a long time to complete.

<!--- Block(grpcLatencyHighOverview) -->
{{ file.Block "grpcLatencyHighOverview" }}
<!--- EndBlock(grpcLatencyHighOverview) -->

## Investigation

### Honeycomb

If there are a large volume of requests with high latencies some information on the details of the requests may be available in Honeycomb. Note that honeycomb samples requests (usually with a low sampling rate of 1%) so for low frequency issues the odds of finding something in Honeycomb are low.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces should provide an idea as to what could be the root cause of the latency.

<!--- Block(grpcLatencyHighHoneycomb)) -->
{{ file.Block "grpcLatencyHighHoneycomb)" }}
<!--- EndBlock(grpcLatencyHighHoneycomb)) -->

### Datadog Dashboard and Logs

The {{ .Config.Name }} service has a dashboard in Datadog: https://app.datadoghq.com/dashboard/i6z-jcn-azh/terraform-{{ .Config.Name }}

Look for any anomalies in the dashboard.

{{ camelcase .Config.Name }} logs are available via a search: https://app.datadoghq.com/logs/livetail?query=service%3A{{ .Config.Name }}%20environment%3Aproduction%20status%3Aerror&index=main&from_ts=1652033594145&to_ts=1652206394145&live=true. Modify the search parameters to match the bento and environment the alert was generated from.

Look for signs of issues or abnormal behavior.

<!--- Block(grpcLatencyHighDatadog) -->
{{ file.Block "grpcLatencyHighDatadog" }}
<!--- EndBlock(grpcLatencyHighDatadog) -->


<!--- Block(grpcLatencyHighInvestigation)) -->
{{ file.Block "grpcLatencyHighInvestigation)" }}
<!--- EndBlock(grpcLatencyHighInvestigation)) -->

## Resolution

<!--- Block(grpcLatencyHighResolution) -->
{{ file.Block "grpcLatencyHighResolution" }}
<!--- EndBlock(grpcLatencyHighResolution) -->

<!--- Block(grpcLatencyHighExtra)) -->
{{ file.Block "grpcLatencyHighExtra)" }}
<!--- EndBlock(grpcLatencyHighExtra)) -->
