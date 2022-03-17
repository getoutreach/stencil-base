{{- $types := (stencil.Arg "type") }}
{{- if not (stencil.Arg "forceRenderMarkdown") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Rollout Plan 🧊 -->

# Rollout Plan

## To Next-Gen Bento

<!--- Block(ngbRollout) -->
{{- if file.Block "ngbRollout" }}
{{ file.Block "ngbRollout" }}
{{- end }}
<!--- EndBlock(ngbRollout) -->

## To Legacy Bento

<!--- Block(legacyRollout) -->
{{- if file.Block "legacyRollout" }}
{{ file.Block "legacyRollout" }}
{{- end }}
<!--- EndBlock(legacyRollout) -->
