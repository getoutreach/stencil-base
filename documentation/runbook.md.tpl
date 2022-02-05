{{- $types := (stencil.Arg "type") }}
{{- if not (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ (stencil.Arg "opslevel").confluenceSpaceKey }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ stencil.Arg "name" }} 🧊 -->
<!-- Title: {{ stencil.Arg "name" }} Runbook 🧊 -->

# {{ stencil.Arg "name" }} Runbook

## General Debugging

### Kubernetes Resources

To view all of the kubernetes resources created by {{ stencil.Arg "name" }}, use the following command after
switching into the appropriate context using `orc context`:

```shell
kubectl -n {{ .appName }}--<bento> get all
```

<!--- Block(generalDebugging) -->
{{- if .generalDebugging }}
{{ .generalDebugging }}
{{- end }}
<!--- EndBlock(generalDebugging) -->

## Debugging Specific Alerts

<!--- Block(debuggingSpecificAlerts) -->
{{- if .debuggingSpecificAlerts }}
{{ .debuggingSpecificAlerts }}
{{- end }}
<!--- EndBlock(debuggingSpecificAlerts) -->
