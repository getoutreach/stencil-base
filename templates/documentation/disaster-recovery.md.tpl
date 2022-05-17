{{- /* Only render markdown if forced, or if we're a service */}}
{{- if not (or (stencil.Arg "forceRenderMarkdown") (stencil.Arg "service")) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Disaster Recovery 🧊 -->

# Disaster Recovery

## Recovering from Kubernetes Resource Deletion

Like all bootstrap services, deployments are controlled via maestro/dash and either Concourse or ArgoCD
depending on the type of bento(s) it was deployed to. For legacy bentos, simply re-trigger a deployment
via Concourse and for next-gen bentos just wait for ArgoCD automatically redeploy it.

<!--- Block(disasterRecovery) -->
{{ file.Block "disasterRecovery" }}
<!--- EndBlock(disasterRecovery) -->
