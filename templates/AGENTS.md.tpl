# AI Agent instructions

Ignore lines containing "Stencil::Block"; they are templates. Purpose: concise rules and actionable workflows for AI-assisted contributors.

## Project purpose

<!-- <<Stencil::Block(projectPurpose)>> -->
{{ file.Block "projectPurpose" }}
<!-- <</Stencil::Block>> -->

## Directory structure


{{- $extraHook := (stencil.GetModuleHook "directoryStructure") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

* **./service.yaml**: File used as configuration for `stencil` program containing additional arguments and stencil modules to use
* **./stencil.lock**: File used as record for:
  1. What modules where used and their version
  2. What module owns which file
  3. If a file is not listed here, the owner is current repository

## Components

{{- $extraHook := (stencil.GetModuleHook "agentsComponents") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

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
