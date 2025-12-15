[task_config]
includes = [
{{- range (stencil.GetModuleHook "miseTaskIncludes") }}
{{ . | quote | indent 2 }},
{{- end }}
  ".bootstrap/.mise/tasks",
  ".mise/tasks",
]

[env]
{{- range (stencil.GetModuleHook "miseEnvironment") }}
{{ . | toToml }}
{{- end }}

## <<Stencil::Block(customMiseEnvironment)>>
{{ file.Block "customMiseEnvironment" }}
## <</Stencil::Block>>

[tools]
"npm:prettier" = {{ stencil.Arg "versions.prettier" | quote }}

{{- range stencil.GetModuleHook "miseTools" }}
{{ . | toToml }}
{{- end }}

## <<Stencil::Block(customMiseTools)>>
{{ file.Block "customMiseTools" }}
## <</Stencil::Block>>

## <<Stencil::Block(extraMise)>>
{{ file.Block "extraMise" }}
## <</Stencil::Block>>
