{
  "license": "UNLICENSED",
  "devDependencies": {
    "@outreach/semantic-release-circleci-orb": "^1.1.9",
    "@semantic-release/commit-analyzer": "^9.0.2",
    "@semantic-release/exec": "^6.0.3",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^8.0.5",
    "@semantic-release/npm": "^9.0.1",
    "@semantic-release/release-notes-generator": "^10.0.3",
    "conventional-changelog-conventionalcommits": "^5.0.0",
{{- if has "node" (stencil.Arg "grpcClients") }}
    "hjson": "^3.2.2",
{{- end }}
    "prettier": "^2.7.1",
    "semantic-release": "^19.0.3",
    "semver": "^7.3.7"
  }
}
