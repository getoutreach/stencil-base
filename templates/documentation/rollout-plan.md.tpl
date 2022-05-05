{{- /* Only render markdown if forced, or if we're a service */}}
{{- if or (not (stencil.Arg "forceRenderMarkdown")) (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Rollout Plan 🧊 -->

# Rollout Plan

## To Next-Gen Bento

<!--- Block(ngbRollout) -->
{{ file.Block "ngbRollout" }}
<!--- EndBlock(ngbRollout) -->

## To Legacy Bento

<!--- Block(legacyRollout) -->
{{ file.Block "legacyRollout" }}
<!--- EndBlock(legacyRollout) -->

## To a New Cluster/Region

<!--- Block(newClusterRegion) -->
{{ file.Block "newClusterRegion" }}
<!--- EndBlock(newClusterRegion) -->
