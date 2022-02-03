<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Services (auto-generated) -->
<!-- Parent: {{ stencil.Arg "name" }} (auto-generated) -->
<!-- Title: {{ stencil.Arg "name" }} Service Level Objectives (auto-generated) -->

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
