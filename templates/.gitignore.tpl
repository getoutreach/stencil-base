# Binaries for programs and plugins
*.exe
*.exe~
*.dll
*.so
*.dylib

# Editor files
*.swp
*~
\#*\#
.idea/*
TAGS
*.sublime-project
*.sublime-workspace
.\#*
.dir-locals.el

# Test binary, build with "go test -c"
*.test

# Output of the go coverage tool, specifically when used with LiteIDE
*.out

# Log files
*.log

# Releases and other binaries
bin/
dist/

# Don't. Commit. Vendor. Or other package manager dep directories
node_modules
vendor

# Fetched by make
concourse/jsonnet-libs

# pulumi secrets, obtained from vault
Pulumi.*.yaml

# terraform
.terraform

# macOS
.DS_Store

# Ruby gRPC client
*.gem

# bootstrap libs
.bootstrap

# CircleCI cache version
/cache-version.txt

# DevSpace files
/.devspace
/deployments/{{ .Config.Name }}.yaml

# Documentation output
/apidocs

### Start ignores inserted by other modules
{{- $extraHook := (stencil.GetModuleHook "extraIgnores") }}
{{- range $extraHook }}
{{- .}}
{{- end }}
### End ignores inserted by other modules

## <<Stencil::Block(extras)>>
{{ file.Block "extras" }}
## <</Stencil::Block>>
