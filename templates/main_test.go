package main

import (
	"testing"

	"github.com/getoutreach/stencil/pkg/stenciltest"
)

// Replace this with your own tests.
func TestRenderAFile(t *testing.T) {
	st := stenciltest.New(t, ".releaserc.yaml.tpl", "_helpers.tpl")
	st.Args(map[string]any{})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderReadmeFile(t *testing.T) {
	st := stenciltest.New(t, "README.md.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"description": "My service",
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderPullRequestTemplateFile(t *testing.T) {
	st := stenciltest.New(t, ".github/pull_request_template.md.tpl", "_helpers.tpl")
	st.Args(map[string]any{})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderCodeownersFile(t *testing.T) {
	st := stenciltest.New(t, ".github/CODEOWNERS.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"reportingTeam": "foo-bar",
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderCodeownersWithExtraOwnersFile(t *testing.T) {
	st := stenciltest.New(t, ".github/CODEOWNERS.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"reportingTeam": "foo-bar",
		"additionalRepoOwners": []any{
			"bar-baz",
			"baz-quux",
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderPackageJSON(t *testing.T) {
	st := stenciltest.New(t, "package.json.tpl", "_helpers.tpl")
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderPackageJSONWithoutReleases(t *testing.T) {
	st := stenciltest.New(t, "package.json.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"releaseOptions": map[string]any{
			"enabled": false,
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderMiseTOML(t *testing.T) {
	st := stenciltest.New(t, "mise.toml.tpl", "_helpers.tpl")
	st.Args(map[string]any{})
	st.Run(stenciltest.RegenerateSnapshots())
}
