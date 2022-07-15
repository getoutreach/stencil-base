{{- $grpc := (has "grpc" (stencil.Arg "serviceActivities")) }}
{{- if or (not (stencil.Arg "service")) (not $grpc) }}
{{- file.Skip "project is not a service with grpc service activity" }}
{{- end }}
{{- $dashboard := stencil.Arg "datadogDashboards.mainLink" }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} gRPC Success Rate Low 🧊 -->

# {{ camelcase .Config.Name }} gRPC Success Rate Low

This indicates that there are gRPC requests that are returning unintended server errors.

<!--- Block(grpcSuccessRateLowOverview) -->
{{ file.Block "grpcSuccessRateLowOverview" }}
<!--- EndBlock(grpcSuccessRateLowOverview) -->

## Investigation

### Honeycomb

If there are a large volume of requests with errors some information on the details of the requests may be available in Honeycomb. Note that honeycomb samples requests (usually with a low sampling rate of 1%) so for low frequency issues the odds of finding something specific in Honeycomb are low.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces may provide an idea as to what could be the root cause of the errors.

<!--- Block(grpcSuccessRateLowHoneycomb)) -->
{{ file.Block "grpcSuccessRateLowHoneycomb)" }}
<!--- EndBlock(grpcSuccessRateLowHoneycomb)) -->

### Datadog Dashboard and Logs

The {{ .Config.Name }} service has a [Datadog dashboard]({{ $dashboard }}). 

Look for any anomalies in the dashboard.

To look for signs of issues or abnormal behavior in the logs, [navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in.

<!--- Block(grpcSuccessRateLowDatadog) -->
{{ file.Block "grpcSuccessRateLowDatadog" }}
<!--- EndBlock(grpcSuccessRateLowDatadog) -->


<!--- Block(grpcSuccessRateLowInvestigation)) -->
{{ file.Block "grpcSuccessRateLowInvestigation)" }}
<!--- EndBlock(grpcSuccessRateLowInvestigation)) -->

## Resolution

Once you determine what the errors are, they usually fall into one of several categories:

1. Errors that should not generate a gRPC error. If this is the case, create a Jira ticket and optionally fix the log entries so that they won’t be counted when generating alerts. Until the log entries are fixed, success rate low errors will continue to be triggered.

2. Errors that are genuinely server errors. These occur for various reasons:

   - Code that is generating gRPC errors because of an unexpected case (example: nil pointer exception). If it's code, create a Jira and optionally fix the code.

   - Service errors because of lack of resources, etc. Follow the instructions in the [Pod Restarts](/documentation/runbooks/pod-restarts.md) runbook if you suspect memory issues need investigation.

<!--- Block(grpcSuccessRateLowResolution) -->
{{ file.Block "grpcSuccessRateLowResolution" }}
<!--- EndBlock(grpcSuccessRateLowResolution) -->

<!--- Block(grpcSuccessRateLowExtra) -->
{{ file.Block "grpcSuccessRateLowExtra" }}
<!--- EndBlock(grpcSuccessRateLowExtra) -->
