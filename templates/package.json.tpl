{
  "license": "UNLICENSED",
{{- $scriptLines := list }}
{{- range $key, $val := stencil.Arg "npm.scripts" }}
{{- $scriptLines = append $scriptLines (printf "    \"%s\": \"%s\"" $key $val) }}
{{- end }}
  "scripts": {
{{ join ",\n" $scriptLines }}
  },
  "devDependencies": {
{{- range $name, $ver := stencil.Arg "npm.devDependencies" }}
    "{{ $name }}": "{{ $ver }}",
{{- end }}
{{- range stencil.GetModuleHook "nodejs_dependencies" }}
    "{{ .name }}": "{{ .version }}",
{{- end }}
{{- if stencil.Arg "releaseOptions.enabled" }}
    "@semantic-release/commit-analyzer": "^13.0.1",
    "@semantic-release/exec": "^7.1.0",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^12.0.2",
    "@semantic-release/npm": "^13.1.3",
    "@semantic-release/release-notes-generator": "^14.1.0",
    "conventional-changelog-conventionalcommits": "^9.1.0",
    "semantic-release": "^25.0.2",
    "semver": "^7.6.0"
{{- end }}
  },
{{- $depLines := list }}
{{- range $name, $ver := stencil.Arg "npm.dependencies" }}
{{- $depLines = append $depLines (printf "    \"%s\": \"%s\"" $name $ver) }}
{{- end }}
  "dependencies": {
{{ join ",\n" $depLines }}
  }
}
