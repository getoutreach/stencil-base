{
  "license": "UNLICENSED",
  "devDependencies": {
{{- range stencil.GetModuleHook "nodejs_dependencies" }}
    "{{ .name }}": "{{ .version }}",
{{- end }}
{{- if stencil.Arg "releaseOptions.enabled" }}
    "@semantic-release/commit-analyzer": "^13.0.1",
    "@semantic-release/exec": "^7.1.0",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^12.0.6",
    "@semantic-release/npm": "^13.1.5",
    "@semantic-release/release-notes-generator": "^14.1.0",
    "conventional-changelog-conventionalcommits": "^9.3.1",
    "semantic-release": "^25.0.3",
    "semver": "^7.7.4"
{{- end }}
  }
}
