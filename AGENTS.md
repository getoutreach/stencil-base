# AI Agent instructions

Ignore lines containing "Stencil::Block"; they are templates. Purpose: concise rules and actionable workflows for AI-assisted contributors.

## Project purpose

<!-- <<Stencil::Block(projectPurpose)>> -->

<!-- <</Stencil::Block>> -->

## Directory structure
* `api/rpc/`: Contains RPC client code templates for API communication.
* `deployments/app/configs/`: Contains Jsonnet configuration templates for application deployment settings.
* `deployments/app/mixins/`: Contains Jsonnet mixin templates for common application deployment patterns.
* `deployments/tf/`: Contains Terraform templates.
* `monitoring/`: Contains Terraform templates for comprehensive monitoring setup.
* `.snapshots/`: Contains snapshot files for testing template rendering outputs.

* **./service.yaml**: File used as configuration for `stencil` program containing additional arguments and stencil modules to use
* **./stencil.lock**: File used as record for:
  1. What modules where used and their version
  2. What module owns which file
  3. If a file is not listed here, the owner is current repository

## Components
What are components? (outreach)

<!-- <<Stencil::Block(agentsComponentsCustom)>> -->

<!-- <</Stencil::Block>> -->

## Other
Other agent information (outreach)

<!-- <<Stencil::Block(agentsOtherCustom)>> -->

<!-- <</Stencil::Block>> -->
