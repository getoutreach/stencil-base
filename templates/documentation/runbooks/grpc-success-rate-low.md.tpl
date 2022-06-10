{{- $grpc := (has "grpc" (stencil.Arg "serviceActivities")) }}
{{- if or (not (stencil.Arg "service")) (not $grpc) }}
{{- file.Skip "project is not a service with grpc service activity" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: Runbooks 🧊 -->
<!-- Title: gRPC Success Rate Low 🧊 -->

# {{ camelcase .Config.Name }} gRPC Success Rate Low

This indicates that there are gRPC requests that are returning unintended server errors.

[Navigate to Datadog](https://app.datadoghq.com/logs?query=service%3A{{ .Config.Name }}%20status%3Aerror) and
add the `@deployment.bento:<bento>` facet, where `<bento>` is the bento that this alert fired in. These logs
should provide an idea as to what could be the root cause of gRPC calls resulting in server-level errors.

<!--- Block(grpcSuccessRateLow) -->
{{ file.Block "grpcSuccessRateLow" }}
<!--- EndBlock(grpcSuccessRateLow) -->
