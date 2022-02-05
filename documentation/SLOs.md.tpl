{{- $types := (stencil.Arg "type") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ stencil.Arg "name" }} 🧊 -->
<!-- Title: {{ stencil.Arg "name" }} Service Level Objectives 🧊 -->

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
