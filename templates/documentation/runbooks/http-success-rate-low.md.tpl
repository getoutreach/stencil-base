{{- $http := (has "http" (stencil.Arg "serviceActivities")) }}
{{- if or (not (stencil.Arg "service")) (not $http) }}
{{- file.Skip "project is not a service with http service activity" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} HTTP Success Rate Low 🧊 -->

# {{ camelcase .Config.Name }} HTTP Success Rate Low

This indicates that there are HTTP requests that are returning unintended server errors.

## Investigation

### Datadog Dashboard and Logs

The {{ .Config.Name }} service has a [Datadog dashboard]({{ $dashboard }}). 

Look for any anomalies in the dashboard.

[Navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in. These logs
should provide an idea as to what could be the root cause of HTTP calls resulting in server-level errors.

<!--- Block(httpSuccessRateLowDatadog) -->
{{ file.Block "httpSuccessRateLowDatadog" }}
<!--- EndBlock(httpSuccessRateLowDatadog) -->

### Honeycomb

If there are a large volume of requests with errors some information on the details of the requests may be available in Honeycomb. Note that honeycomb samples requests (usually with a low sampling rate of 1%) so for low frequency issues the odds of finding something specific in Honeycomb are low.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces should provide an idea as to what could be the root cause of the latency.

<!--- Block(httpSuccessRateLowHoneycomb)) -->
{{ file.Block "httpSuccessRateLowHoneycomb)" }}
<!--- EndBlock(httpSuccessRateLowHoneycomb)) -->

<!--- Block(httpSuccessRateLowInvestigation) -->
{{ file.Block "httpSuccessRateLowInvestigation" }}
<!--- EndBlock(httpSuccessRateLowInvestigation) -->

## Resolution

<!--- Block(httpSuccessRateLowResolution) -->
{{ file.Block "httpSuccessRateLowResolution" }}
<!--- EndBlock(httpSuccessRateLowResolution) -->

<!--- Block(httpSuccessRateLow) -->
{{ file.Block "httpSuccessRateLow" }}
<!--- EndBlock(httpSuccessRateLow) -->
