{{- $types := (stencil.Arg "type") }}
{{- if not (stencil.Arg "forceRenderMarkdown") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} Runbook 🧊 -->

# {{ .Config.Name }} Runbook

## General Debugging

### Kubernetes Resources

To view all of the kubernetes resources created by {{ .Config.Name }}, use the following command after
switching into the appropriate context using `orc context`:

```shell
kubectl -n {{ .Config.Name }}--<bento> get all
```

<!--- Block(generalDebugging) -->
{{- if file.Block "generalDebugging" }}
{{ file.Block "generalDebugging" }}
{{- end }}
<!--- EndBlock(generalDebugging) -->

## Debugging Specific Alerts

<!--- Block(debuggingSpecificAlerts) -->
{{- if file.Block "debuggingSpecificAlerts" }}
{{ file.Block "debuggingSpecificAlerts" }}
{{- end }}
<!--- EndBlock(debuggingSpecificAlerts) -->
