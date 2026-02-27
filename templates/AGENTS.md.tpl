# AI Agent instructions

Ignore all lines containing "Stencil::Block".
These are template instructions and should not be included in the final output.

## Critical rules

### Mandatory Linting Workflow

**YOU MUST RUN LINTERS BEFORE CLAIMING ANY CODING TASK IS COMPLETE.**

Skipping linters wastes the user's time by forcing them to manually find errors that linters would catch automatically.

#### Completion Checklist

After writing or modifying ANY Go code:

```bash
# 1. Format the code
gofmt -w <modified-files>
goimports -w <modified-files>

# 2. RUN LINTERS (DO NOT SKIP THIS)
cd $MONOREPO_PATH
PATH="$BASH5_PATH:$PATH" make lint

# This runs ALL linters: golangci-lint, lintroller, shellcheck, eslint, buf, tflint, etc.

# 3. Fix ALL linter errors immediately
# 4. Re-run linters until output is clean
# 5. Only then is the task complete
```

#### Required Confirmation

At the end of every coding task, you MUST include:

```
Linting Status:
✅ Ran: PATH="$BASH5_PATH:$PATH" make lint
✅ Result: All linters passing (or list of remaining issues)
✅ All errors fixed
```

**If you do not run linters and confirm the results, you have NOT completed the task.**

#### When to Run Linters

1. Immediately after writing a new file
2. Immediately after modifying an existing file
3. Before claiming any task is complete
4. When you see a linter error, fix it immediately - don't defer it

#### Handling Linter Violations

When the linter reports any issue:

1. **Read the error message carefully** - Understand what's being reported and why
2. **Fix the root cause** - Don't just suppress warnings; address the underlying issue
3. **Re-run the linter** - Verify the fix resolved the issue completely
4. **Never skip linting** - Even if the code compiles, linters catch important issues

**If you don't understand a linter error:**

- Research the specific linter rule to understand its purpose
- Ask the user for clarification if needed
- NEVER ignore or suppress the error without understanding it

#### DO NOT:

- ❌ Skip linters because "the code compiles"
- ❌ Skip linters because "it's similar to code I wrote before"
- ❌ Skip linters because "they're slow"
- ❌ Wait for the user to find linter errors
- ❌ Fix linter errors one-by-one as the user reports them

**Zero tolerance: Run linters. Always. This is wasting the user's time otherwise.**

---

### Mandatory Testing Workflow

**YOU MUST RUN TESTS BEFORE CLAIMING ANY CODING TASK IS COMPLETE.**

Skipping tests wastes the user's time by allowing broken code to be committed. If tests fail, you have NOT completed the task.

#### Testing Checklist

After writing or modifying ANY code:

```bash
# Run the full test suite
cd $MONOREPO_PATH
PATH="$BASH5_PATH:$PATH" make test

# Fix ALL test failures immediately
# Re-run tests until all tests pass
# Only then is the task complete
```

#### Required Confirmation

At the end of every coding task, you MUST include:

```
Testing Status:
✅ Ran: PATH="$BASH5_PATH:$PATH" make test
✅ Result: All tests passing (or list of failures with fixes)
✅ All test failures fixed
```

**If you do not run tests and confirm all tests pass, you have NOT completed the task.**

#### When to Run Tests
1. After writing new code or modifying existing code
2. Before claiming any task is complete
3. After fixing linter errors (linting can sometimes break tests)
4. When you see a test failure, fix it immediately - don't defer it

#### Handling Test Failures

When tests fail:

1. **Read the failure message carefully** - Understand what's failing and why
2. **Fix the root cause** - Don't just update tests to pass; fix the actual issue
3. **Re-run the tests** - Verify the fix resolved the failure completely
4. **Never skip failing tests** - Even if "most tests pass", all tests must pass

**If you don't understand a test failure:**
- Read the test code to understand what it's validating
- Check if your changes broke existing functionality
- Ask the user for clarification if needed
- NEVER ignore or skip failing tests

#### DO NOT:
- ❌ Skip tests because "the code looks correct"
- ❌ Skip tests because "they're slow"
- ❌ Skip tests because "only one test is failing"
- ❌ Wait for the user to find test failures
- ❌ Assume tests will pass without running them

**Zero tolerance: Run tests. Always. Broken tests mean broken code.**

---

### Semantic Versioning & Breaking Changes

**NEVER include "BREAKING CHANGE" in commit messages or PR descriptions without explicit user approval.**

The repositories use semantic-release with conventional commits:
- `fix:` → Patch version (1.0.0 → 1.0.1)
- `feat:` → Minor version (1.0.0 → 1.1.0)
- `BREAKING CHANGE:` in commit body/footer → **Major version** (1.0.0 → 2.0.0)

#### Rules

1. **NEVER** add "BREAKING CHANGE" to any commit message or PR description
2. **NEVER** use the `!` suffix (e.g., `feat!:` or `fix!:`) which also triggers major versions
3. **ALWAYS** use only `feat:` or `fix:` prefixes unless explicitly told otherwise
4. **WARN the user** if you detect that changes might be breaking, but let them decide

#### Before Any Commit/PR That Could Be Breaking

- Identify if the change breaks backward compatibility
- **Warn explicitly**: "This change may be breaking because [reason]. Do you want to mark it as a BREAKING CHANGE (which will trigger a major version bump)?"
- Wait for explicit approval before adding any breaking change markers

**Example warnings:**
- "Changing this function signature will break existing callers. Mark as BREAKING CHANGE?"
- "Removing this public API will affect consumers. Trigger major version bump?"
- "This behavior change may impact existing users. Mark as breaking?"

**Zero tolerance:** Including "BREAKING CHANGE" or `!` without explicit approval wastes the user's time and potentially disrupts versioning strategy.

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

<!-- <<Stencil::Block(additionalAgentsInfo)>> -->
{{ file.Block "additionalAgentsInfo" }}
<!-- ## <</Stencil::Block>> -->
