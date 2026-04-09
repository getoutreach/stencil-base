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

func TestRenderPackageJSONWithScripts(t *testing.T) {
	st := stenciltest.New(t, "package.json.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"npm": map[string]any{
			"scripts": map[string]any{
				"build": "tsc -b",
				"test":  "jest",
			},
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderPackageJSONWithDevDependencies(t *testing.T) {
	st := stenciltest.New(t, "package.json.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"npm": map[string]any{
			"devDependencies": map[string]any{
				"typescript": "^5.0.0",
				"jest":       "^29.0.0",
			},
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderPackageJSONWithDependencies(t *testing.T) {
	st := stenciltest.New(t, "package.json.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"npm": map[string]any{
			"dependencies": map[string]any{
				"express": "^4.18.0",
				"lodash":  "^4.17.21",
			},
		},
	})
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

func TestRenderMiseTOMLWithNewerHardMinMiseVersion(t *testing.T) {
	st := stenciltest.New(t, "mise.toml.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"versions": map[string]any{
			"mise": map[string]any{
				"hard": "2380.6.8",
			},
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderMiseTOMLWithOlderHardMinMiseVersion(t *testing.T) {
	st := stenciltest.New(t, "mise.toml.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"versions": map[string]any{
			"mise": map[string]any{
				"hard": "2020.3.15",
			},
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderMiseTOMLWithInvalidHardMinMiseVersion(t *testing.T) {
	st := stenciltest.New(t, "mise.toml.tpl", "_helpers.tpl")
	st.Args(map[string]any{
		"versions": map[string]any{
			"mise": map[string]any{
				"hard": "latest",
			},
		},
	})
	st.ErrorContains("invalid semantic version")
	st.Run(stenciltest.RegenerateSnapshots())
}
