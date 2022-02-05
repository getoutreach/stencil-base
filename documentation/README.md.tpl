{{- $types := (stencil.Arg "type") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
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
