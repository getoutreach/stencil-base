{{- /* Only render markdown if forced, or if we're a service */}}
{{- if or (not (stencil.Arg "forceRenderMarkdown")) (eq (stencil.ApplyTemplate "isService") "true") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Service Level Objectives 🧊 -->

# Service Level Objectives

<!--- Block(customSLOs) -->
{{ file.Block "customSLOs" }}
<!--- EndBlock(customSLOs) -->

{{- if has "http" (stencil.Arg "type") }}
## HTTP P99 Latency

99.9% success rate from the "HTTP Latency High" datadog monitor, which enforces the following:

* P90 <= 2s during times of low traffic.
* P99 <= 2s during times of high traffic.

Where "low traffic" means during the last 15 minutes less than or equal to 1000 requests have
been observed.

## HTTP Success Rate

99.9% success rate on public HTTP requests where success rate is calculated as the count of
all >= 500 code responses over all responses, multiplied by 100.
{{- end }}
