# This file contains tool versions for use with asdf
# Note: Versions in this block override the default versions below.
# Be EXTREMELY CAREFUL with this. If you override a standard version
# you are reducing compatibility guarantees.
## <<Stencil::Block(toolver)>>
{{- if file.Block "toolver" }}
{{ file.Block "toolver" }}
{{- end }}
## <</Stencil::Block>>
{{- range stencil.GetModuleHook "toolVersions" }}
{{ printf "%s %s" .name (toString .version) }}
{{- end }}
