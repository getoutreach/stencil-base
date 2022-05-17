{{- /* Only render markdown if forced, or if we're a service */}}
{{- if not (or (stencil.Arg "forceRenderMarkdown") (stencil.Arg "service")) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Title: {{ .Config.Name }} 🧊 -->

# {{ .Config.Name }}

## Relevant External Documentation

* [Design Document]({{ stencil.Arg "opslevel.designDocumentLink" }})
<!--- Block(documentation) -->
{{ file.Block "documentation" }}
<!--- EndBlock(documentation) -->
