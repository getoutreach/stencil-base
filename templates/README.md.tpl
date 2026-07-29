{{- $_ := file.Static -}}
# {{ .Config.Name }}

{{- if (stencil.Arg "oss") }}
[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](https://pkg.go.dev/github.com/{{ .Runtime.Box.Org }}/{{ .Config.Name }})
{{- else }}
[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)]({{ .Runtime.Box.Engdocs.URL }}/github.com/{{ .Runtime.Box.Org }}/{{ .Config.Name }})
{{- end }}
{{- if ne nil (stencil.Arg "circleAPIKey") }}
{{- if ne "" (stencil.Arg "circleAPIKey") }}
[![CircleCI](https://circleci.com/gh/{{ .Runtime.Box.Org }}/{{ .Config.Name }}.svg?style=shield&circle-token={{ stencil.Arg "circleAPIKey" }})](https://circleci.com/gh/{{ .Runtime.Box.Org }}/{{ .Config.Name }})
{{- end }}
{{- end }}
[![Generated via Bootstrap](https://img.shields.io/badge/Outreach-Bootstrap-%235951ff)](https://github.com/getoutreach/bootstrap)
[![Coverage Status](https://coveralls.io/repos/github/{{ .Runtime.Box.Org }}/{{ .Config.Name }}/badge.svg?branch={{ .Git.DefaultBranch }})](https://coveralls.io/github//{{ .Runtime.Box.Org }}/{{ .Config.Name }}?branch={{ .Git.DefaultBranch }})

{{ stencil.Arg "description" }}

## Contributing

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) document for guidelines on developing and contributing changes.

## High-level Overview

[TODO]

{{- if (stencil.Arg "service") }}
## Dependencies

{{- if not (stencil.Arg "oss") }}
Make sure you have run `orc setup` recently.
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
{{- end }}

{{- if (stencil.Arg "service") }}

### Adding and Deleting Service in Development Environment

First, make sure you [set up your development environment](https://github.com/getoutreach/devenv#getting-started).

To add this service to your developer environment:
```bash
devenv apps deploy {{ .Config.Name }}
```

To delete this service from your developer environment:
```bash
devenv apps delete {{ .Config.Name }}
```

{{- $serviceActivityDescriptions := stencil.GetModuleHook "serviceActivityDescriptions" }}
{{- if not (empty $serviceActivityDescriptions) }}
## Interacting with {{ title (.Config.Name) }}

{{- range $serviceActivityDescriptions }}
{{ . }}
{{- end }}

{{- end }}
{{- end }}
