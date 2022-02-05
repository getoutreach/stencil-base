{{- $types := (stencil.Arg "type") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ stencil.Arg "name" }} 🧊 -->
<!-- Title: {{ stencil.Arg "name" }} Rollout Plan 🧊 -->

# Rollout Plan

## To Next-Gen Bento

<!--- Block(ngbRollout) -->
{{- if .ngbRollout }}
{{ .ngbRollout }}
{{- end }}
<!--- EndBlock(ngbRollout) -->

## To Legacy Bento

<!--- Block(legacyRollout) -->
{{- if .legacyRollout }}
{{ .legacyRollout }}
{{- end }}
<!--- EndBlock(legacyRollout) -->
