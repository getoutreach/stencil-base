{{- $types := (stencil.Arg "type") }}
{{- if ne nil (stencil.Arg "forceRenderMarkdown") }}
{{- if eq false (stencil.Arg "forceRenderMarkdown") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- end }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ stencil.Arg "name" }} 🧊 -->
<!-- Title: {{ stencil.Arg "name" }} Disaster Recovery 🧊 -->

# Disaster Recovery

## Recovering from Kubernetes Resource Deletion

Like all bootstrap services, deployments are controlled via maestro/dash and either Concourse or ArgoCD
depending on the type of bento(s) it was deployed to. For legacy bentos, simply re-trigger a deployment
via Concourse and for next-gen bentos just wait for ArgoCD automatically redeploy it.

<!--- Block(disasterRecovery) -->
{{- if .disasterRecovery }}
{{ .disasterRecovery }}
{{- end }}
<!--- EndBlock(disasterRecovery) -->
