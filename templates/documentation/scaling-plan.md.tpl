{{- /* Only render markdown if forced, or if we're a service */}}
{{- if not (or (stencil.Arg "forceRenderMarkdown") (stencil.Arg "service")) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Scaling Plan 🧊 -->

# Scaling Plan

<!-- <<Stencil::Block(scalingPlan)>> -->
{{ file.Block "scalingPlan" }}
<!-- <</Stencil::Block>> -->
