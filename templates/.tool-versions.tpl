# This file contains tool versions for use with asdf
# Note: Versions in this block override the default versions below.
# Be EXTREMELY CAREFUL with this. If you override a standard version
# you are reducing compatibility guarantees.
###Block(toolverOverride)
{{- if file.Block "toolverOverride" }}
{{ file.Block "toolverOverride" }}
{{- end }}
###EndBlock(toolverOverride)
{{- range stencil.GetModuleHook "toolVersions" }}
{{ printf "%s %s" .name (toString .version) }}
{{- end }}
# Note: Versions in this block do not override the default versions above
# but sometimes you have to declare additional versions of the same tool
# while leaving the 'default' version intact for the infra.
# The most common case is nodejs.
###Block(toolver)
{{- if file.Block "toolver" }}
{{ file.Block "toolver" }}
{{- end }}
###EndBlock(toolver)
