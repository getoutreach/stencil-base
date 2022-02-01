{{- $library := false }}
{{- $http := false }}
{{- $grpc := false }}
{{- $clerk := false }}
{{- $temporal := false }}
{{- $cli := false }}
{{- $kafka := false }}
{{- range (stencil.Arg "type") }}
{{- if eq . "library" }}
{{- $library = true }}
{{- end }}
{{- if eq . "http" }}
{{- $http = true }}
{{- end }}
{{- if eq . "grpc" }}
{{- $grpc = true }}
{{- end }}
{{- if eq . "clerk" }}
{{- $clerk = true }}
{{- end }}
{{- if eq . "temporal" }}
{{- $temporal = true }}
{{- end }}
{{- if eq . "cli" }}
{{- $cli = true }}
{{- end }}
{{- if eq . "kafka" }}
{{- $kafka = true }}
{{- end }}
{{- end }}
{{- $service := true }}
{{- if (and $library (and (not $http) (and (not $grpc) (and (not $clerk) (and (not $temporal) (and (not $kafka) (not $cli))))))) }}
{{- $service = false }}
{{- end }}
# {{ stencil.Arg "name" }}

{{- if .manifest.OSS }}
[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](https://pkg.go.dev/github.com/getoutreach/{{ .repo }})
{{- else }}
[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](https://engdocs.outreach.cloud/github.com/getoutreach/{{ .repo }})
{{- end }}
[![CircleCI](https://circleci.com/gh/getoutreach/{{ .repo }}.svg?style=shield&circle-token=<YOUR_STATUS_API_TOKEN:READ:https://circleci.com/docs/2.0/status-badges/>)](https://circleci.com/gh/getoutreach/{{ .repo }})
[![Generated via Bootstrap](https://img.shields.io/badge/Outreach-Bootstrap-%235951ff)](https://github.com/getoutreach/bootstrap)

{{ stencil.Arg "description" }}

----

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) document for guidelines on developing and contributing changes.

## High-level Overview

<!--- Block(overview) -->
{{- if .overview }}
{{ .overview }}
{{- end }}
<!--- EndBlock(overview) -->

{{- if $service }}
## Dependencies

{{- if not (stencil.Arg "oss") }}
Make sure you've followed the [Launch Plan](https://outreach-io.atlassian.net/wiki/spaces/EN/pages/695698940/Launch+Plan).
{{- end }}

### Dependencies

{{- if not (empty (stencil.Arg "dependencies.required"))}}
#### Required Dependencies
{{- range (stencil.Arg "dependencies.required") }}
* {{ . }}
{{- end }}
{{- end }}

{{- if not (empty (stencil.Arg "dependencies.optional"))}}
#### Optional Dependencies
{{- range (stencil.Arg "dependencies.optional") }}
* {{ . }}
{{- end }}
{{- end}}

### Add to your Development Environment

[Set up your development environment](https://github.com/getoutreach/devenv#getting-started), then run:

```bash
devenv deploy-app {{ stencil.Arg "name" }}
```

{{- if or $grpc (or $http (or $clerk $temporal)) }}
## Interacting with {{ title (stencil.Arg "name") }}

{{- if $grpc }}
### via gRPC

[grpcui](https://github.com/fullstorydev/grpcui) can be useful for talking to {{ stencil.Arg "name" }} locally. To run it:

```bash
make grpcui
```
{{- end }}

{{- if $http }}
### via HTTP

There are two different HTTP servers running by default on stencil services, a public (external) and a private
(internal) server. By default, the port for the public server is `8080`, and the port for the private server is `8000`.
These are subject to change, and if they are changed, those changes should be reflected in
`deployments/{{ stencil.Arg "name" }}/{{ stencil.Arg "name" }}.config.jsonnet`.

If the service is running locally either through running `make devserver` or running the binary directly, you can
interact with these servers over `localhost` or `127.0.0.1` using the appropriate port.

If the service is running in kubernetes you'll either have to launch an alpine pod into the namespace and interact with
the HTTP servers using cURL (make sure to `apk add curl` in the alpine container) or you can port-forward to get access
to them on your local network:

```bash
devenv kubectl -n {{ stencil.Arg "name" }}--bento1a port-forward service/{{ stencil.Arg "name" }} <port>
```

Where port is either the port for the public or private HTTP server.
{{- end }}

{{- if $clerk }}
### via Clerk

The clerk field in service.yaml generates stubs to communicate with clerk. Using this a service can produce and consume
clerk messages to and from kafka. For more details on how this works, please click
[here](https://outreach-io.atlassian.net/wiki/spaces/DP/pages/2290876556/clerk+bootstrap+integration).
{{- end }}

{{- if $temporal }}
### via Temporal

Coming soon.
{{- end }}
{{- end }}
{{- end }}