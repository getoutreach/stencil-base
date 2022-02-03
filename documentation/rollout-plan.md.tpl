<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Services (auto-generated) -->
<!-- Parent: {{ stencil.Arg "name" }} (auto-generated) -->
<!-- Title: {{ stencil.Arg "name" }} Rollout Plan (auto-generated) -->

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
