<!-- Space: {{ stencil.Arg "confluenceSpaceKey" }} -->
<!-- Parent: {{ stencil.Arg "name" }} -->
<!-- Title: Disaster Recovery -->

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
