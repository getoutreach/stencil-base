{
  "license": "UNLICENSED",
  "devDependencies": {
    "@semantic-release/commit-analyzer": "^11.0.0",
    "@semantic-release/exec": "^6.0.3",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^9.2.1",
    "@semantic-release/npm": "^11.0.1",
    "@semantic-release/release-notes-generator": "^12.0.0",
    "conventional-changelog-conventionalcommits": "^7.0.2",
{{- if has "node" (stencil.Arg "grpcClients") }}
    "hjson": "^3.2.2",
{{- end }}
{{- range stencil.GetModuleHook "nodejs_dependencies" }}
    "{{ .name }}": "{{ .version }}",
{{- end }}
    "prettier": "^3.0.3",
    "semantic-release": "^22.0.6",
    "semver": "^7.5.4"
  },
  "packageManager": "yarn@4.0.1"
}
