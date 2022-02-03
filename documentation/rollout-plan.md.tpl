<!-- Space: {{ stencil.Arg "confluenceSpaceKey" }} -->
<!-- Parent: {{ stencil.Arg "name" }} -->
<!-- Title: Rollout Plan -->

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
