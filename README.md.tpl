# {{ GetArg "name" }}

[![go.dev reference](https://img.shields.io/badge/go.dev-reference-007d9c?logo=go&logoColor=white)](<REPLACE WITH DOCUMENTATION LINK>{{ GetArg "name" }})
[![CircleCI](https://circleci.com/gh/getoutreach/{{ GetArg "name" }}.svg?style=shield&circle-token=<YOUR_STATUS_API_TOKEN:READ:https://circleci.com/docs/2.0/status-badges/>)](https://circleci.com/gh/getoutreach/{{ GetArg "name" }})
[![Generated via Stencil](https://img.shields.io/badge/Outreach-Stencil-%235951ff)](https://github.com/getoutreach/stencil)

<!--- Block(description) -->
{{ GetArg "description" }}
<!--- EndBlock(description) -->

----

[Developing and contributing changes](CONTRIBUTING.md) |
[Generated Documentation](<REPLACE WITH DOCS LINK>{{ .repo }}/)

<!--- Block(custom) -->
{{- if .custom }}
{{ .custom }}
{{- else }}
# PLEASE EDIT THIS
{{- end }}
<!--- EndBlock(custom) -->

## Dependencies and Setup

### Dependencies

Make sure you've followed the [Launch Plan](https://outreach-io.atlassian.net/wiki/spaces/EN/pages/695698940/Launch+Plan).

<!--- Block(dependencies) -->
{{- if .dependencies }}
{{ .dependencies }}
{{- end }}
<!--- EndBlock(dependencies) -->

{{- if not .library }}
### Add to your Development Environment

[Set up your development environment](https://github.com/getoutreach/devenv#getting-started), then run:

```
devenv deploy-app {{ GetArg "name" }}
```

<!--- Block(devenvSetup) -->
{{- if .devenvSetup }}
{{ .devenvSetup }}
{{- end }}
<!--- EndBlock(devenvSetup) -->

{{- if eq "grpc" (GetArg "type") }}
## Interacting with {{ title (GetArg "name") }}

[grpcui](https://github.com/fullstorydev/grpcui) can be useful for talking to {{ GetArg "name" }} locally. To run it:

```bash
make grpcui
```
{{- end }}
{{- end }}
