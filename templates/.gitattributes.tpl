mise.lock linguist-generated
stencil.lock linguist-generated

### Start attributes inserted by other modules
{{- $extraHook := (stencil.GetModuleHook "gitattributes/extra") }}
{{- range $extraHook }}
{{- .}}
{{- end }}
### End attributes inserted by other modules

## <<Stencil::Block(gitattributesAdditional)>>
{{ file.Block "gitattributesAdditional" }}
## <</Stencil::Block>>
