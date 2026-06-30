# {{ .Config.Name }}

Ignore lines containing "Stencil::Block"; they are areas in your generated code that you’d like to persist across runs and are repository specific. These lines are for template generator and do not contain agent instructions.

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
mise tasks ls # List all tasks available through mise.
mise run <task> # Run a task available through mise.

# make
{{- if (stencil.Arg "service") }}
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
| Stencil commands | [docs/stencil-commands.md](./docs/agents/stencil-commands.md) |
| Mise commands | [docs/mise-commands.md](./docs/agents/mise-commands.md) |
{{- $extraHook := (stencil.GetModuleHook "agentsReferencesTable") }}
{{- range $extraHook }}
{{- . }}
{{- end }}
<!-- <<Stencil::Block(referencesTableCustom)>> -->
{{ file.Block "referencesTableCustom" }}
<!-- <</Stencil::Block>> -->

## Boundaries

### Always

- Run `make fmt` after making code changes
- Run `make lint` after making code changes and fix any issues
- Keep functions small and single-purpose
- Check `stencil.lock` to determine file ownership before modifying generated files
- Prefer running `mise` tasks over make targets
{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesAlways") }}
{{- range $extraHook }}
{{- .}}
{{- end }}
<!-- <<Stencil::Block(agentsBoundariesAlwaysCustom)>> -->
{{ file.Block "agentsBoundariesAlwaysCustom" }}
<!-- <</Stencil::Block>> -->

### Ask

- Write unit tests for new functions and bug fixes
- Before deleting or significantly refactoring a package or file
- Before changing public API signatures (exported functions, types, or interfaces)
- Before adding new external dependencies
- Before bumping major versions of dependencies
- Before changing database schema or migration files // maybe different module?
{{- $extraHook := (stencil.GetModuleHook "agentsBoundariesAsk") }}
{{- range $extraHook }}
{{- .}}
{{- end }}
<!-- <<Stencil::Block(agentsBoundariesAskCustom)>> -->
{{ file.Block "agentsBoundariesAskCustom" }}
<!-- <</Stencil::Block>> -->

### Never

- Commit secrets, credentials, API keys, or tokens
- Force-push to main or protected branches
- Disable or skip linters/tests to make a build pass
- Ignore or swallow errors silently (e.g., _ = someFunc() without justification)
- Add TODO or FIXME comments without a linked issue or explanation
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
