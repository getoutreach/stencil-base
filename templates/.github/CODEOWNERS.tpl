# See https://help.github.com/articles/about-codeowners/
{{- $orgName := .Runtime.Box.Org }}
* @{{ $orgName }}/{{ stencil.Arg "reportingTeam" }}{{ range stencil.Arg "additionalRepoOwners" }} @{{ $orgName }}/{{ . }}{{ end }}

## <<Stencil::Block(customCodeowners)>>
{{ file.Block "customCodeowners" }}
## <</Stencil::Block>>
