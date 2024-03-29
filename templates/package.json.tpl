{
  "license": "UNLICENSED",
  "devDependencies": {
    "@semantic-release/commit-analyzer": "^10.0.1",
    "@semantic-release/exec": "^6.0.3",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^9.0.3",
    "@semantic-release/npm": "^10.0.4",
    "@semantic-release/release-notes-generator": "^11.0.3",
    "conventional-changelog-conventionalcommits": "^6.0.0",
{{- if has "node" (stencil.Arg "grpcClients") }}
    "hjson": "^3.2.2",
{{- end }}
{{- range stencil.GetModuleHook "nodejs_dependencies" }}
    "{{ .name }}": "{{ .version }}",
{{- end }}
    "prettier": "^2.8.8",
    "semantic-release": "^21.0.5",
    "semver": "^7.5.2"
  }
}
