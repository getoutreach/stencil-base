{{- $types := (stencil.Arg "type") }}
{{- if ne nil (stencil.Arg "forceRenderMarkdown") }}
{{- if eq false (stencil.Arg "forceRenderMarkdown") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- end }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Title: {{ stencil.Arg "name" }} 🧊 -->

# {{ stencil.Arg "name" }}

## Relevant External Documentation

* [Design Document]({{ (stencil.Arg "opslevel").designDocumentLink }})
<!--- Block(documentation) -->
{{- if .documentation }}
{{ .documentation }}
{{- end }}
<!--- EndBlock(documentation) -->
