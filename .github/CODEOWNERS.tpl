# See https://help.github.com/articles/about-codeowners/
* @getoutreach/{{ stencil.Arg "reportingTeam" }}

###Block(customCodeowners)
{{- if file.Block "customCodeowners" }}
{{ file.Block "customCodeowners" }}
{{- end }}
###EndBlock(customCodeowners)
