{{ $name := stencil.Arg "name" }}
# {{ $name }}

[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](https://pkg.go.dev/github.com/getoutreach/{{ .repo }})
[![CircleCI](https://circleci.com/gh/getoutreach/{{ $name }}.svg?style=shield)](https://circleci.com/gh/getoutreach/{{ .repo }})
[![Generated via Stencil](https://img.shields.io/badge/Outreach-Stencil-%235951ff)](https://github.com/getoutreach/stencil)

<!--- Block(description) -->
{{ stencil.Arg "description" }}
<!--- EndBlock(description) -->

----

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) document for guidelines on developing and contributing changes.

<!--- Block(custom) -->
{{- if .custom }}
{{ .custom }}
{{- else }}
# PLEASE EDIT THIS
{{- end }}
<!--- EndBlock(custom) -->

## Dependencies and Setup

### Dependencies

<!--- Block(dependencies) -->
{{- if .dependencies }}
{{ .dependencies }}
{{- end }}
<!--- EndBlock(dependencies) -->

{{- if empty (stencil.Arg "type") }}
### Add to your Development Environment

[Set up your development environment](https://github.com/getoutreach/devenv#getting-started), then run:

```
devenv deploy-app {{ $name }}
```

<!--- Block(devenvSetup) -->
{{- if .devenvSetup }}
{{ .devenvSetup }}
{{- end }}
<!--- EndBlock(devenvSetup) -->

{{- if has (stencil.Arg "type") "grpc" }}
## Interacting with {{ $name }}

[grpcui](https://github.com/fullstorydev/grpcui) can be useful for talking to {{ $name }} locally. To run it:

```bash
make grpcui
```
{{- end }}
{{- end }}
