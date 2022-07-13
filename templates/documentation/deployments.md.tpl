{{- /* Only render markdown if forced, or if we're a service */}}
{{- if not (or (stencil.Arg "forceRenderMarkdown") (stencil.Arg "service")) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Deployments 🧊 -->

# Deployments

## Environments

The {{ camelcase .Config.Name }} service is deployed to all bentos. In order to inspect the deployments and pods associated with the {{ camelcase .Config.Name }} service you will first need to ensure the correct kubernetes context is set for the environment you intend to inspect.

You can set the appropriate kubernetes context for the bento using the following mapping:

- dev environment:
  - `kubectx dev-environment`
- staging1a bento:
  - `kubectx staging.us-east-2`
- app1\* bentos:
  - `kubectx production.us-west-2`
- app2\* bentos:
  - `kubectx production.us-east-1`
- app4a bento:
  - `kubectx app4a`

<!--- Block(deploymentsEnvironments) -->
{{ file.Block "deploymentsEnvironments" }}
<!--- EndBlock(deploymentsEnvironments) -->

<!--- Block(deployments) -->
{{ file.Block "deployments" }}
<!--- EndBlock(deployments) -->
