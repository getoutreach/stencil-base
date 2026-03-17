# This file contains tool versions for use with asdf
# Note: Versions in this block override the default versions below.
# Be EXTREMELY CAREFUL with this. If you override a standard version
# you are reducing compatibility guarantees.
## <<Stencil::Block(toolverOverride)>>
{{- if file.Block "toolverOverride" }}
{{ file.Block "toolverOverride" }}
{{- end }}
## <</Stencil::Block>>
nodejs {{ stencil.Arg "versions.nodejs" }}
{{- range stencil.GetModuleHook "toolVersions" }}
{{ printf "%s %s" .name (toString .version) }}
{{- end }}
# Note: Versions in this block do not override the default versions above
# but sometimes you have to declare additional versions of the same tool
# while leaving the 'default' version intact for the infra.
# The most common case is nodejs.
## <<Stencil::Block(toolver)>>
{{- if file.Block "toolver" }}
{{ file.Block "toolver" }}
{{- end }}
## <</Stencil::Block>>
