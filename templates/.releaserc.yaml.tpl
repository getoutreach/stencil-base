{{- $prereleases := stencil.Arg "releaseOptions.enablePrereleases" }}
preset: conventionalcommits
branches:
{{- if $prereleases }}
  - name: {{ .Git.DefaultBranch }}
    prerelease: 'rc'
  - name: release
{{- else }}
  - name: {{ .Git.DefaultBranch }}
{{- end }}
plugins:
  - - "@semantic-release/commit-analyzer"
    - releaseRules:
      - type: revert
        release: patch
      - type: perf
        release: patch

  {{- if not (stencil.Arg "releaseOptions.allowMajorVersions") }}
  # Block major version upgrades due to us not supporting them that well. This can
  # be disabled by setting releaseOptions.allowMajorVersions, but be warned this
  # is not well supported for services.
  - - "@semantic-release/exec"
    # We use generateNotesCmd instead of verifyConditionsCmd because it has access
    # to last/nextRelease due to when the step runs.
    - generateNotesCmd: |-
        ./scripts/shell-wrapper.sh major-release-checker.js ${lastRelease.version} ${nextRelease.version}
  {{- end }}

{{- if gt (len (stencil.Arg "commands")) 0 }}
  # Build the binaries
  - - "@semantic-release/exec"
    # We use generateNotesCmd instead of a different step because it has access
    # to last/nextRelease due to when the step runs.
    - generateNotesCmd: "make release APP_VERSION=${nextRelease.version}"
{{- end }}

  # This creates fancy release notes in our Github release
  - "@semantic-release/release-notes-generator"

{{- if has "grpc" (stencil.Arg "type") }}
  {{- if has "node" (stencil.Arg "grpcClients") }}
  # Bump npm package.json version, and release to npm/github packages.
  # See devbase for the Github Packages part.
  - - "@semantic-release/npm"
    - pkgRoot: api/clients/node
  {{- end -}}
  {{- if has "ruby" (stencil.Arg "grpcClients") }}
  # Release ruby packages
  - - "@semantic-release/exec"
    # We use generateNotesCmd because prepareCmd is not ran on dry-run
    - generateNotesCmd: |-
        ./scripts/shell-wrapper.sh ruby/build.sh ${nextRelease.version} 1>&2
      publishCmd: |-
        DRYRUN=${options.dryrun} ./scripts/shell-wrapper.sh ruby/publish.sh ${nextRelease.version}
  {{- end }}
  {{- if not (empty (stencil.Arg "grpcClients")) }}
  # Store the package.json updates in Git
  - - "@semantic-release/git"
    - assets:
        {{- if has "node" (stencil.Arg "grpcClients") }}
        - api/clients/node/package.json
        {{- end }}
        {{- if has "ruby" (stencil.Arg "grpcClients") }}
        - api/clients/ruby/lib/{{ .Config.Name }}_client/version.rb
        {{- end }}
  {{- end }}
{{- end }}

{{- if gt (len (stencil.Arg "commands")) 0 }}
  # Create the Github Release
  - - "@semantic-release/github"
    - assets:
        - "dist/*.tar.gz"
        - "dist/checksums.txt"
{{- else }}
  - "@semantic-release/github"
{{- end }}
{{- $hook := (stencil.GetModuleHook "releaseConfig") }}
{{- if $hook }}
{{ toYaml $hook | indent 2 }}
{{- end }}
