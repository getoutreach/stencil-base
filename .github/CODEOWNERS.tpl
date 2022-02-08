# See https://help.github.com/articles/about-codeowners/
* @getoutreach/{{ stencil.Arg "reportingTeam" }}

###Block(customCodeowners)
{{- if .customCodeowners }}
{{ .customCodeowners }}
{{- end }}
###EndBlock(customCodeowners)