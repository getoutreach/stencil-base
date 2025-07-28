[task_config]
includes = [".bootstrap/.mise/tasks"]

[env]
{{- range (stencil.GetModuleHook "miseEnvironment") }}
{{ . | toToml }}
{{- end }}

## <<Stencil::Block(customMiseEnvironment)>>
{{ file.Block "customMiseEnvironment" }}
## <</Stencil::Block>>

[tools]
"npm:prettier" = "2"

{{- range stencil.GetModuleHook "miseTools" }}
{{ . | toToml }}
{{- end }}

## <<Stencil::Block(customMiseTools)>>
{{ file.Block "customMiseTools" }}
## <</Stencil::Block>>

## <<Stencil::Block(extraMise)>>
{{ file.Block "extraMise" }}
## <</Stencil::Block>>
