{{- /* mise 2026.3.2 introduces `mise upgrade --local` */ -}}
{{- $defaultHardMiseVersion := "2026.3.2" -}}
{{- $hardMiseVersion := "" -}}
{{- $hardMiseVersionArg := stencil.Arg "versions.mise.hard" -}}
{{- if and (ne $hardMiseVersionArg "") (semverCompare (printf ">%s" $defaultHardMiseVersion) $hardMiseVersionArg) -}}
{{- $hardMiseVersion = $hardMiseVersionArg -}}
{{- else -}}
{{- $hardMiseVersion = $defaultHardMiseVersion -}}
{{- end -}}
min_version = { hard = {{ $hardMiseVersion | quote }} }

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

[hooks]
enter = [
  "$MISE_PROJECT_ROOT/scripts/devbase.sh",
]

## <<Stencil::Block(customMiseHooks)>>
{{ file.Block "customMiseHooks" }}
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
