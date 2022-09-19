{{- /* Only render markdown if forced, or if we're a service */}}
{{- if not (or (stencil.Arg "forceRenderMarkdown") (stencil.Arg "service")) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Rollout Plan 🧊 -->

# Rollout Plan

## To Next-Gen Bento

<!-- <<Stencil::Block(ngbRollout)>> -->
{{ file.Block "ngbRollout" }}
<!-- <</Stencil::Block>> -->

## To Legacy Bento

<!-- <<Stencil::Block(legacyRollout)>> -->
{{ file.Block "legacyRollout" }}
<!-- <</Stencil::Block>> -->

## To a New Cluster/Region

<!-- <<Stencil::Block(newClusterRegion)>> -->
{{ file.Block "newClusterRegion" }}
<!-- <</Stencil::Block>> -->
