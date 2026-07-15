# stencil-base

Ignore lines containing "Stencil::Block"; they are areas in your generated code that you’d like to persist across runs and are repository specific. These lines are for template generator and do not contain agent instructions.

## Description

<!-- <<Stencil::Block(agentsProjectOverview)>> -->
Base templates for a Stencil-managed repository.
<!-- <</Stencil::Block>> -->

## Project overview

<!-- <<Stencil::Block(projectOverview)>> -->
`stencil-base` is a [Stencil module](https://engineering.outreach.io/stencil/reference/modules/), not a runnable service: it provides the base templates rendered into every Stencil-managed repository at Outreach.
The source of truth is `templates/*.tpl` (Go text templates, helpers in `templates/_helpers.tpl`); root-level files are rendered outputs — edit the template, not the output.
`manifest.yaml` defines the module's arguments and post-run commands; tests are `stenciltest` snapshot tests (`go test ./templates/...`, snapshots in `templates/.snapshots/`).
This repository consumes itself via a `./` replacement in `service.yaml`.
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
# <<Stencil::Block(customCommands)>>

# <</Stencil::Block>>
```

## Directory structure

* service.yaml: File used as configuration for `stencil` program containing additional arguments and stencil modules to use
* stencil.lock: File used as record for:
  1. What modules were used and their version
  2. What module owns which file
  3. If a file is not listed here, the owner is current repository
* docs/: Directory used to store documentation files and reference materials for the project.
<!-- <<Stencil::Block(directoryStructureCustom)>> -->

<!-- <</Stencil::Block>> -->

If you need more context, you can find more information in `docs/` directory.

## References table

| Description | Reference |
|----|----|
| Stencil commands | [docs/agents/stencil-commands.md](./docs/agents/stencil-commands.md) |
| Mise commands | [docs/agents/mise-commands.md](./docs/agents/mise-commands.md) |
<!-- <<Stencil::Block(referencesTableCustom)>> -->

<!-- <</Stencil::Block>> -->

## Boundaries

### Always
<!-- <<Stencil::Block(agentsBoundariesAlwaysCustom)>> -->

<!-- <</Stencil::Block>> -->

### Ask

- Before changing public API signatures (exported functions, types, or interfaces)
- Before adding new external dependencies
- Before bumping major versions of dependencies
- Before changing database schema or migration files
<!-- <<Stencil::Block(agentsBoundariesAskCustom)>> -->

<!-- <</Stencil::Block>> -->

### Never

- Commit secrets, credentials, API keys, or tokens
<!-- <<Stencil::Block(agentsBoundariesNeverCustom)>> -->

<!-- <</Stencil::Block>> -->

## Other
<!-- <<Stencil::Block(agentsOtherCustom)>> -->

<!-- <</Stencil::Block>> -->
