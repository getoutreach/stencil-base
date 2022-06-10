{{- $http := (has "http" (stencil.Arg "serviceActivities")) }}
{{- if or (not (stencil.Arg "service")) (not $http) }}
{{- file.Skip "project is not a service with http service activity" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: Runbooks 🧊 -->
<!-- Title: HTTP Latency High 🧊 -->

# {{ camelcase .Config.Name }} HTTP Latency High

This indicates that there are HTTP requests that are taking a long time to complete.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces should provide an idea as to what could be the root cause of the latency.

<!--- Block(httpLatencyHigh) -->
{{ file.Block "httpLatencyHigh" }}
<!--- EndBlock(httpLatencyHigh) -->
