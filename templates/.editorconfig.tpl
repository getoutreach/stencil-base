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

[*.py]
indent_style = space
indent_size = 4

[*.{json,toml}]
indent_style = space
indent_size = 2

[*.md]
trim_trailing_whitespace = false

## <<Stencil::Block(editorconfig)>>
{{ file.Block "editorconfig" }}
## <</Stencil::Block>>
