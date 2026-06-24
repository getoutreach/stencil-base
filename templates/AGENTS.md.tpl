# {{ .Config.Name }}

Ignore lines containing "Stencil::Block"; they are areas in your generated code that you’d like to persist across runs and are repository specific. These lines are for template generator and do not contain agent instructions.

## Description

<!-- <<Stencil::Block(agentsProjectOverview)>> -->
{{ file.Block "agentsProjectOverview" }}
<!-- <</Stencil::Block>> -->

## Project overview

<!-- <<Stencil::Block(projectOverview)>> -->
{{ file.Block "projectOverview" }}
<!-- <</Stencil::Block>> -->

## Generic commands

```bash
# stencil
stencil # Run stencil program with arguments specified in service.yaml file

{{- if (stencil.Arg "service") }}
make build # Build project.
make test # Run tests.
{{- end }}
make fmt # Run formatters on project's code.
make lint # Run linters on project's code.

{{- $extraHook := (stencil.GetModuleHook "agentsGenericCommands") }}
{{- range $extraHook }}
{{- . }}

{{- end }}

# <<Stencil::Block(customCommands)>>
{{ file.Block "customCommands" }}
# <</Stencil::Block>>
```

## Directory structure

* service.yaml: File used as configuration for `stencil` program containing additional arguments and stencil modules to use
* stencil.lock: File used as record for:
  1. What modules were used and their version
  2. What module owns which file
  3. If a file is not listed here, the owner is current repository
* docs/: Directory used to store documentation files and reference materials for the project.

{{- $extraHook := (stencil.GetModuleHook "agentsDirectoryStructure") }}
{{- range $extraHook }}
{{- . }}
{{- end }}

<!-- <<Stencil::Block(directoryStructureCustom)>> -->
{{ file.Block "directoryStructureCustom" }}
<!-- <</Stencil::Block>> -->

If you need more context, you can find more information in `docs/` directory. If the directory does not exist, ignore this line.

## References table

| Description | Reference |
|----|----|
| Stencil commands | [docs/stencil-commands.md](./docs/stencil-commands.md) |
| Mise commands | [docs/mise-commands.md](./docs/mise-commands.md) |
{{- $extraHook := (stencil.GetModuleHook "agentsReferencesTable") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(referencesTableCustom)>> -->
{{ file.Block "referencesTableCustom" }}
<!-- <</Stencil::Block>> -->

<!--- {{- if (stencil.Arg "service") }} -->
<!--- * Run `make build` to build project. -->
<!--- * Run `make test` to run tests. -->
<!--- {{- end }} -->
<!--- * Run `make fmt` to format project. -->
<!--- * Run `make lint` to run linters on project's code. -->

{{- $extraHook := (stencil.GetModuleHook "agentsReferences") }}
{{- range $extraHook }}
{{- .}}
{{- end }}


<!-- <<Stencil::Block(agentsReferencesCustom)>> -->
{{ file.Block "agentsReferencesCustom" }}
<!-- <</Stencil::Block>> -->

## Boundaries

### Always

{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesAlways") }}
{{- range $extraHook }}
{{- .}}
{{- end }}


<!-- <<Stencil::Block(agentsBoundariesAlwaysCustom)>> -->
{{ file.Block "agentsBoundariesAlwaysCustom" }}
<!-- <</Stencil::Block>> -->

### Ask

{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesAsk") }}
{{- range $extraHook }}
{{- .}}
{{- end }}


<!-- <<Stencil::Block(agentsBoundariesAskCustom)>> -->
{{ file.Block "agentsBoundariesAskCustom" }}
<!-- <</Stencil::Block>> -->

### Never

{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesNever") }}
{{- range $extraHook }}
{{- .}}
{{- end }}


<!-- <<Stencil::Block(agentsBoundariesNeverCustom)>> -->
{{ file.Block "agentsBoundariesNeverCustom" }}
<!-- <</Stencil::Block>> -->

## Other

{{- $extraHook := (stencil.GetModuleHook "agentsOther") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

<!-- <<Stencil::Block(agentsOtherCustom)>> -->
{{ file.Block "agentsOtherCustom" }}
<!-- <</Stencil::Block>> -->
