[task_config]
includes = [".bootstrap/.mise/tasks"]

{{- $miseEnvironments := stencil.GetModuleHook "miseEnvironment" }}
{{- if gt ($miseEnvironments | len) 0 }}
[env]
{{- range $miseEnvironments }}
{{ . | toToml }}
{{- end }}
{{- end }}

## <<Stencil::Block(customMiseEnvironment)>>
{{ file.Block "customMiseEnvironment" }}
## <</Stencil::Block>>

[tools]
"npm:prettier" = "2"

{{- range $_, $toolMap := stencil.GetModuleHook "miseTools" }}
{{- range $name, $tool := $toolMap }}
{{ $name | quote }} = {{ $tool | toToml }}
{{- end }}
{{- end }}

## <<Stencil::Block(customMiseTools)>>
{{ file.Block "customMiseTools" }}
## <</Stencil::Block>>

## <<Stencil::Block(extraMise)>>
{{ file.Block "extraMise" }}
## <</Stencil::Block>>
