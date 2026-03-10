# AI Agent instructions

Ignore lines containing "Stencil::Block"; they are areas in your generated code that you’d like to persist across runs and are repository specific.

## Project purpose

<!-- <<Stencil::Block(projectPurpose)>> -->
{{ file.Block "projectPurpose" }}
<!-- <</Stencil::Block>> -->

## Directory structure


{{- $extraHook := (stencil.GetModuleHook "directoryStructure") }}
{{- range $extraHook }}
{{- . }}
{{- end }}

* **./service.yaml**: File used as configuration for `stencil` program containing additional arguments and stencil modules to use
* **./stencil.lock**: File used as record for:
  1. What modules were used and their version
  2. What module owns which file
  3. If a file is not listed here, the owner is current repository

If you need more context, you can find more information in `docs/` directory. If the directory does not exist, ignore this line.

## Components

{{- $extraHook := (stencil.GetModuleHook "agentsComponents") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

* Run `make build` to build project.
* Run `make fmt` to format project.
* Run `make lint` to run linters on project's code.
* Run `make test` to run tests.

<!-- <<Stencil::Block(agentsComponentsCustom)>> -->
{{ file.Block "agentsComponentsCustom" }}
<!-- <</Stencil::Block>> -->

## Other

{{- $extraHook := (stencil.GetModuleHook "agentsOther") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

<!-- <<Stencil::Block(agentsOtherCustom)>> -->
{{ file.Block "agentsOtherCustom" }}
<!-- <</Stencil::Block>> -->
