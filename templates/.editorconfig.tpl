root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = true

[*.go,Makefile]
indent_style = tab

[*.{bash,rb,sh,slim,yml,yaml}]
indent_style = space
indent_size  = 2

## <<Stencil::Block(editorconfig)>>
{{ file.Block "editorconfig" }}
## <</Stencil::Block>>
