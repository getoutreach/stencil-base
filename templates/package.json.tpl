{
  "license": "UNLICENSED",
  "devDependencies": {
    "@semantic-release/commit-analyzer": "^9.0.1",
    "@semantic-release/exec": "^6.0.1",
    "@semantic-release/git": "^10.0.0",
    "@semantic-release/github": "^8.0.1",
    "@semantic-release/npm": "^9.0.0",
    "@semantic-release/release-notes-generator": "^10.0.2",
    "conventional-changelog-conventionalcommits": "^4.6.1",
{{- if has "node" (stencil.Arg "grpcClients") }}
    "hjson": "^3.2.2",
{{- end }}
    "prettier": "^2.3.2",
    "semantic-release": "^19.0.0",
    "semver": "^7.3.5"
  }
}
