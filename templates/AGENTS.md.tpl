# {{ .Config.Name }}

Ignore lines containing `Stencil::Block`; they are areas in your generated code that you'd like to persist across runs and are repository specific. These lines are for the template generator and do not contain agent instructions.

## Description

<!-- <<Stencil::Block(agentsProjectOverview)>> -->
{{ default (stencil.Arg "description") (file.Block "agentsProjectOverview") }}
<!-- <</Stencil::Block>> -->

## Project overview

<!-- <<Stencil::Block(projectOverview)>> -->
{{ file.Block "projectOverview" }}
<!-- <</Stencil::Block>> -->

## Generic commands

```bash
# stencil
stencil # Run stencil program with arguments specified in service.yaml file

# mise
mise --help # Show help for mise commands.

# make
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
* stencil.lock: A lockfile for Stencil which also declares which files in the repo are managed, and which module manages it. Third party generated files are not cataloged.
* docs/: Directory used to store documentation files and reference materials for the project.
{{- $extraHook := (stencil.GetModuleHook "agentsDirectoryStructure") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(directoryStructureCustom)>> -->
{{ file.Block "directoryStructureCustom" }}
<!-- <</Stencil::Block>> -->

If you need more context, you can find more information in `docs/` directory.

## References table

| Description | Reference |
|----|----|
| Stencil commands | [docs/agents/stencil-commands.md](./docs/agents/stencil-commands.md) |
{{- $extraHook := (stencil.GetModuleHook "agentsReferencesTable") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(referencesTableCustom)>> -->
{{ file.Block "referencesTableCustom" }}
<!-- <</Stencil::Block>> -->

## Boundaries

### Always

{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesAlways") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(agentsBoundariesAlwaysCustom)>> -->
{{ file.Block "agentsBoundariesAlwaysCustom" }}
<!-- <</Stencil::Block>> -->

### Ask

Before each scenario in the following list, ask the user if they allow the change to occur. For every question, include: root reason for change, list the tradeoffs for the change.

- Changing public API signatures (exported functions, types, or interfaces)
- Adding new external dependencies
- Bumping major versions of dependencies
- Changing database schema or migration files
{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesAsk") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(agentsBoundariesAskCustom)>> -->
{{ file.Block "agentsBoundariesAskCustom" }}
<!-- <</Stencil::Block>> -->

### Never

- Commit secrets, credentials, API keys, or tokens
{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesNever") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(agentsBoundariesNeverCustom)>> -->
{{ file.Block "agentsBoundariesNeverCustom" }}
<!-- <</Stencil::Block>> -->

## Other

{{- $extraHook := (stencil.GetModuleHook "agentsOther") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(agentsOtherCustom)>> -->
{{ file.Block "agentsOtherCustom" }}
<!-- <</Stencil::Block>> -->
