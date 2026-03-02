# AI Agent instructions

Ignore all lines containing "Stencil::Block".
These are template instructions and should not be included in the final output.

# AI Agent guidance

Ignore lines containing "Stencil::Block"; they are templates.

Purpose: concise rules and actionable workflows for AI-assisted contributors.

**Quick Start**

{{- $extraHook := (stencil.GetModuleHook "projectQuickStart") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

## Critical rules (short)

- Run linters and tests before declaring work complete.
- Include the required lint/test status blocks in PR descriptions (see templates below).
- Follow Conventional Commits for commits and do NOT mark breaking changes without explicit approval.

---

## Linting workflow (detailed)

{{- $extraHook := (stencil.GetModuleHook "projectLintingWorkflow") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

## Critical rules

### Mandatory Linting Workflow

{{- $extraHook := (stencil.GetModuleHook "projectCriticalRules_MandatoryLintingWorkflow") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

---

### Mandatory Testing Workflow

{{- $extraHook := (stencil.GetModuleHook "projectCriticalRules_MandatoryTestingWorkflow") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

---

### Understanding Established Patterns

**Before writing any new code, understand the patterns already established in the repository.**

#### Pattern Research Workflow

When starting work on a codebase:

1. **Ask the user for a reference package** - Request a specific package that exemplifies the coding style
2. **Research existing patterns** - Read similar code to understand conventions
3. **Match the established style** - Follow existing patterns for consistency
4. **Ask if unclear** - Don't guess; verify your understanding

**Key patterns to identify:**
- **Error handling** - How are errors returned? Wrapped? Logged?
- **Logging** - When are logs added? What log levels are used? What context is included?
- **Naming conventions** - Variable naming style, function naming patterns
- **File organization** - How are files structured? Where do different types go?
- **Testing patterns** - Existing test structure, mock usage, assertion style
- **Documentation** - Comment style, package documentation standards

**Example approach:**
```
"Before I write this new function, which package should I reference
to understand the established error handling and logging patterns?"
```

**DO NOT:**
- ❌ Introduce new patterns without discussion
- ❌ Mix different error handling styles in the same package
- ❌ Add logging that's inconsistent with existing patterns
- ❌ Use different naming conventions than the rest of the codebase

**CRITICAL: Consistency with existing code is more important than personal preference or external best practices.**

---

### No External Assumptions

**Don't bring in assumptions based on external knowledge about the domain or common patterns.**

Even if a concept or pattern is well-known across the industry, this codebase might have different requirements, constraints, or implementations.

#### Rules

1. **Ask questions to clarify assumptions** - Before implementing anything based on "how it's usually done"
2. **Understand project-specific constraints** - Every codebase has unique requirements and edge cases
3. **Verify your understanding** - Don't assume; confirm with the user

**Example:**
- ❌ "Sync engines typically work this way, so I'll implement it like that"
- ✅ "I know sync engines often use pattern X, but what are the specific requirements and constraints for this project?"

**Common areas where assumptions fail:**
- Architecture patterns (even if they're "industry standard")
- API design conventions
- Data flow and transformation logic
- Error handling and retry mechanisms
- Performance requirements and constraints

**CRITICAL: Understanding the specific requirements and constraints of THIS codebase is more important than applying generic best practices.**

---

## Project overview

<!-- <<Stencil::Block(customProjectOverview)>> -->
{{ file.Block "customProjectOverview" }}
<!-- <</Stencil::Block>> -->

## Project organization

{{- $extraHook := (stencil.GetModuleHook "projectDirectories") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

If some of the directories do not exist, ignore their definitions.
If no directories are defined, find more information in `docs/` directory.

## Build and test commands

{{- $extraHook := (stencil.GetModuleHook "projectCommands") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

## Code style

{{- $extraHook := (stencil.GetModuleHook "projectCodeStyle") }}
{{- range $extraHook }}
{{- .}}
{{- end }}

## Version control

### Commit message format

Commit messages must conform to the [Conventional Commits v1.0
specification](https://www.conventionalcommits.org/en/v1.0.0/). Acceptable types:

* `feat` (minor version bump) - user-facing feature that is not a breaking change.
* `fix` (patch version bump) - fix to an existing feature in the service or to the deployment
  configuration (jsonnet).
* `revert` (patch version bump) - reverts a previous commit, must include the ID of the commit
  in question.
* `perf` (patch version bump, does not change existing functionality)
* `refactor` (no version bump) - changes to the existing code that does not change existing
  functionality or performance.
* `ci` (no version bump) - related to the CI/CD system of the service.
* `build` (no version bump) - related to the build system that does not require
  a release.
* `docs` (no version bump) - related to the non-user-facing documentation.

DO NOT put Jira ticket IDs in the commit title. It SHOULD go into the commit description.

If a single prompt to a tool (e.g. GitHub Copilot) was used to create the commit, then the prompt
MUST be included in the commit description:
```
AI prompt: [Prompt]
```

Example:

```
AI prompt: rename all instances of "helper" to "agent", preserving existing formatting.
```

If a design spec was provided along with a prompt as input to a tool that produced a working change,
or a plan was generated through AI conversational prompts, the spec or detailed plan (without an
"implementation steps" section, or any instructions already covered in `AGENTS.md`) MUST be checked
in alongside the code in `documentation/specs/$jiraID/` (where `$jiraID` is the Jira ticket ID
associated with the design spec) and the prompt MUST be included in the commit description.

AI agents MUST disclose what tool and model they are using in the `Assisted-By` commit footer:

```
Assisted-By: [Model Name] via [Tool Name]
```

For example:
```
Assisted-By: LLM 1.2.3 via Claude Code
```

## Performance & scaling for agents

- Prefer batching requests to external services where possible.
- Use local caching for repeated prompt/template results.
- Set concurrency limits and worker-pool sizes; measure CPU/RAM and tune.
- Use exponential backoff with jitter for retries to avoid thundering herds.
- Profile slow paths and cache expensive computations.

---

## Observability & metrics

- Emit counts for requests, errors, latencies, and cache hit rates.
- Tag metrics by agent type, prompt template, and external service.
- Create alerts for error rate spikes and latency regressions.

---

## Security & secrets

- Never commit secrets.
- Limit API keys with least privilege and rotate regularly.
- Audit logs for agent actions and access to sensitive resources.

---

## Prompting, rate-limit and retry best practices

- Implement idempotency where retries are possible.
- Use rate-limiters and queueing to protect downstream services.
- For external LLMs: use backoff with capped retries and circuit-breakers.

---

## Testing patterns for agents

- Unit tests: mock external LLM responses and test decision logic deterministically.
- Integration tests: run end-to-end against a staging environment or a recorded fixture.
- Use golden files for stable prompt outputs where applicable.

---

## Troubleshooting & FAQ (quick fixes)

- Linter fails: run `gofmt` and `goimports`, then `make lint` to see the full report.
- Test flakes: run the test repeatedly locally, inspect logs, add deterministic fixtures.

---

## Templates & examples

PR completion template (paste into PR description):

```
Linting Status:
✅ Ran: PATH="$BASH5_PATH:$PATH" make lint
✅ Result: All linters passing

Testing Status:
✅ Ran: PATH="$BASH5_PATH:$PATH" make test
✅ Result: All tests passing

AI prompt: <If any AI assistance used, paste the prompt here>
Assisted-By: <Model Name> via <Tool Name>
```

Commit footer template for AI-assisted commits:

```
AI prompt: <prompt used>
Assisted-By: <Model Name> via <Tool Name>
```

---

## Change & release process (summary)

- Use Conventional Commits mentioned in section _Commit message format_.
- Do NOT add `BREAKING CHANGE` or `!` without explicit approval.
- If a change looks breaking, call it out in the PR description and ask for explicit approval.

---

<!-- <<Stencil::Block(additionalAgentsInfo)>> -->
{{ file.Block "additionalAgentsInfo" }}
<!-- ## <</Stencil::Block>> -->
