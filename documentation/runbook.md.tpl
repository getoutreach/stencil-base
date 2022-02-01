# {{ .appName }} Runbook

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
