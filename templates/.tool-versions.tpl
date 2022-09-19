# This file contains tool versions for use with asdf
{{- range stencil.GetModuleHook "toolVersions" }}
{{ printf "%s %s" .name (toString .version) }}
{{- end }}
# Note: Versions in this block override the above. Be EXTREMELY
# CAREFUL with this. If you override a standard version you are
# reducing compatibility guarantees.
## <<Stencil::Block(toolver)>>
{{- if file.Block "toolver" }}
{{ file.Block "toolver" }}
{{- end }}
## <</Stencil::Block>>
