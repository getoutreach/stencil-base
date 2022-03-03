{{- $types := (stencil.Arg "type") }}
{{- $isService := (or (has "http" $types) (or (has "grpc" $types) (or (has "kafka" $types) (has "temporal" $types)))) }}
# {{ stencil.Arg "name" }}

<!--- Block(customGeneralInformation) -->
{{- if .customGeneralInformation }}
{{ .customGeneralInformation }}
{{- end }}
<!--- EndBlock(customGeneralInformation) -->

## Prerequisites

{{- if and $isService (not (stencil.Arg "oss")) }}
Make sure you've ran `orc setup`.
{{- end }}

<!--- Block(customPrerequisites) -->
{{- if .customPrerequisites }}
{{ .customPrerequisites }}
{{- end }}
<!--- EndBlock(customPrerequisites) -->

## Building and Testing

<!--- Block(customBuildingAndTesting) -->
{{- if .customBuildingAndTesting }}
{{ .customBuildingAndTesting }}
{{- end }}
<!--- EndBlock(customBuildingAndTesting) -->

{{- if $isService }}
### Building and Running

If you want to add this to your developer environment, please check out the section in the
README.md about [adding to this developer environment](https://github.com/getoutreach/{{ stencil.Arg "name" }}#add-to-your-development-environment).

If you want to run this locally, you can do the following:

```bash
devenv provision
devenv tunnel
```

and in a separate terminal, since `devenv tunnel` is a blocking operation, run the following
in the root of this repository:

```bash
make devserver
```

This will build and run your project locally, using the developer environment to provide any
integrations and dependent services that are tunneled to your local network.

### Generating Deployment Manifests Locally

If you want to observe the deployment manifests generated when running the service in the developer
environemt, you can leverage the following script:

```bash
./scripts/shell-wrapper.sh deploy-to-dev.sh show
```
{{- end }}

{{- if has "library" $types }}
### Replacing a Remote Version of the Library with Local Version

If you want to test the library exposed in this repository in a project that uses it, you can
add the following `replace` directive to that project's `go.mod` file:

```
replace github.com/getoutreach/{{ stencil.Arg "name" }} => /path/to/local/version/{{ stencil.Arg "name" }}
```

**_Note_**: This library may have postfixed it's module path with a version, go check the first
line of the `go.mod` file in this repository to see if that is the case. If that is the case,
you will need to modify the first part of the replace directive (the part before the `=>`) with
that postfixed path.
{{- end }}

### Linting and Unit Testing

You can run the the linters and unit tests with:

```bash
make test
```

{{- if $isService }}
### End-to-end Testing

You can run end-to-end tests with:

```bash
make e2e
```

This leverages the developer environment to interact with dependent integrations and services. If
an already provisioned environment exists it will use that, else it will create one.
{{- end }}
