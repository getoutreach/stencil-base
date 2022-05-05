# {{ .Config.Name }}

{{- if (stencil.Arg "oss") }}
[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](https://pkg.go.dev/github.com/getoutreach/{{ .Config.Name }})
{{- else }}
[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](https://engdocs.outreach.cloud/github.com/getoutreach/{{ .Config.Name }})
{{- end }}
{{- if ne nil (stencil.Arg "circleAPIKey") }}
{{- if ne "" (stencil.Arg "circleAPIKey") }}
[![CircleCI](https://circleci.com/gh/getoutreach/{{ .Config.Name }}.svg?style=shield&circle-token={{ stencil.Arg "circleAPIKey" }})](https://circleci.com/gh/getoutreach/{{ .Config.Name }})
{{- end }}
{{- end }}
[![Generated via Bootstrap](https://img.shields.io/badge/Outreach-Bootstrap-%235951ff)](https://github.com/getoutreach/bootstrap)
[![Coverage Status](https://coveralls.io/repos/github/{{ .Runtime.Box.Org }}/{{ .Config.Name }}/badge.svg?branch={{ .Git.DefaultBranch }})](https://coveralls.io/github//{{ .Runtime.Box.Org }}/{{ .Config.Name }}?branch={{ .Git.DefaultBranch }})

{{ stencil.Arg "description" }}

## Contributing

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) document for guidelines on developing and contributing changes.

## High-level Overview

<!--- Block(overview) -->
{{ file.Block "overview" }}
<!--- EndBlock(overview) -->

{{- if (stencil.Arg "service") }}
## Dependencies

{{- if not (stencil.Arg "oss") }}
Make sure you've ran `orc setup`.
{{- end }}

### Dependencies

{{- if not (empty (stencil.Arg "dependencies.required")) }}
#### Required Dependencies
{{- range (stencil.Arg "dependencies.required") }}
* {{ . }}
{{- end }}
{{- end }}

{{- if not (empty (stencil.Arg "dependencies.optional")) }}
#### Optional Dependencies
{{- range (stencil.Arg "dependencies.optional") }}
* {{ . }}
{{- end }}
{{- end}}

### Adding and Deleting Service in Development Environment

First, make sure you [set up your development environment](https://github.com/getoutreach/devenv#getting-started).

To add this service to your developer environment:
```bash
devenv apps deploy {{ .Config.Name }}
```

To delete this service from your developer environment:
```bash
devenv apps deploy {{ .Config.Name }}
```

{{- if (stencil.Arg "service") }}
## Interacting with {{ title (.Config.Name) }}

{{- if has "grpc" (stencil.Arg "serviceActivities") }}
### via gRPC

[grpcui](https://github.com/fullstorydev/grpcui) can be useful for talking to {{ .Config.Name }} locally. To run it:

```bash
make grpcui
```
{{- end }}

{{- if has "http" (stencil.Arg "serviceActivities") }}
### via HTTP

There are two different HTTP servers running by default on stencil services, a public (external) and a private
(internal) server. By default, the port for the public server is `8080`, and the port for the private server is `8000`.
These are subject to change, and if they are changed, those changes should be reflected in
`deployments/{{ .Config.Name }}/{{ .Config.Name }}.config.jsonnet`.

If the service is running locally either through running `make devserver` or running the binary directly, you can
interact with these servers over `localhost` or `127.0.0.1` using the appropriate port.

If the service is running in kubernetes you'll either have to launch an alpine pod into the namespace and interact with
the HTTP servers using cURL (make sure to `apk add curl` in the alpine container) or you can port-forward to get access
to them on your local network:

```bash
devenv kubectl -n {{ .Config.Name }}--bento1a port-forward service/{{ .Config.Name }} <port>
```

Where port is either the port for the public or private HTTP server.
{{- end }}

{{- if has "clerk" (stencil.Arg "serviceActivities") }}
### via Clerk

The clerk field in service.yaml generates stubs to communicate with clerk. Using this a service can produce and consume
clerk messages to and from kafka. For more details on how this works, please click
[here](https://outreach-io.atlassian.net/wiki/spaces/DP/pages/2290876556/clerk+bootstrap+integration).
{{- end }}

{{- if has "temporal" (stencil.Arg "serviceActivities") }}
### via Temporal

Coming soon.
{{- end }}
{{- end }}
{{- end }}
