{
  "license": "UNLICENSED",
  "devDependencies": {
    "@semantic-release/commit-analyzer": "^12.0.0",
    "@semantic-release/exec": "^6.0.3",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^10.0.3",
    "@semantic-release/npm": "^12.0.0",
    "@semantic-release/release-notes-generator": "^13.0.0",
    "conventional-changelog-conventionalcommits": "^7.0.2",
{{- if has "node" (stencil.Arg "grpcClients") }}
    "hjson": "^3.2.2",
{{- end }}
{{- range stencil.GetModuleHook "nodejs_dependencies" }}
    "{{ .name }}": "{{ .version }}",
{{- end }}
    "semantic-release": "^23.0.8",
    "semver": "^7.6.0"
  }
}
