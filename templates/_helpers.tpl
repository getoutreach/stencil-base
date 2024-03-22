{{- file.Skip "Virtual file with functions" }}

{{- if and (not (stencil.Arg "service")) (not (empty (stencil.Arg "serviceActivities"))) }}
{{ fail "service has to be set to \"true\" in order to supply \"serviceActivities\"" }}
{{- end }}
