<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Title: {{ stencil.Arg "name" }} -->

# {{ stencil.Arg "name" }}

## Relevant External Documentation

* [Design Document]({{ (stencil.Arg "opslevel").designDocumentLink }})
<!--- Block(documentation) -->
{{- if .documentation }}
{{ .documentation }}
{{- end }}
<!--- EndBlock(documentation) -->
