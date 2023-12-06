package main

import (
	"testing"

	"github.com/getoutreach/stencil/pkg/stenciltest"
)

// Replace this with your own tests.
func TestRenderAFile(t *testing.T) {
	st := stenciltest.New(t, ".releaserc.yaml.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{})
	st.Run(false)
}

func TestRenderReadmeFile(t *testing.T) {
	st := stenciltest.New(t, "README.md.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"description": "My service",
	})
	st.Run(false)
}

func TestRenderPullRequestTemplateFile(t *testing.T) {
	st := stenciltest.New(t, ".github/pull_request_template.md.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{})
	st.Run(false)
}

func TestRenderCodeownersFile(t *testing.T) {
	st := stenciltest.New(t, ".github/CODEOWNERS.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"reportingTeam": "foo-bar",
	})
	st.Run(false)
}

func TestRenderCodeownersWithExtraOwnersFile(t *testing.T) {
	st := stenciltest.New(t, ".github/CODEOWNERS.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"reportingTeam": "foo-bar",
		"additionalRepoOwners": []interface{}{
			"bar-baz",
			"baz-quux",
		},
	})
	st.Run(false)
}
