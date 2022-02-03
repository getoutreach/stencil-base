<!-- Space: {{ stencil.Arg "confluenceSpaceKey" }} -->
<!-- Parent: {{ stencil.Arg "name" }} -->
<!-- Title: Service Level Objectives -->

# Service Level Objectives

<!--- Block(customSLOs) -->
{{- if .customSLOs }}
{{ .customSLOs }}
{{- end }}
<!--- EndBlock(customSLOs) -->

{{- if .http }}
## HTTP P99 Latency

TODO - this information is coming from DDR

## HTTP Success Rate

TODO - this information is coming from DDR
{{- end }}
