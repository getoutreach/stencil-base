package main

import (
	"testing"

	"github.com/getoutreach/stencil/pkg/stenciltest"
)

// Replace this with your own tests.
func TestRenderAFile(t *testing.T) {
	st := stenciltest.New(t, ".releaserc.yaml.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestReleaseRCWithNodeJSGRPCClient(t *testing.T) {
	st := stenciltest.New(t, ".releaserc.yaml.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"service": true,
		"serviceActivities": []interface{}{
			"grpc",
		},
		"grpcClients": []interface{}{
			"node",
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestReleaseRCWithRubyGRPCClient(t *testing.T) {
	st := stenciltest.New(t, ".releaserc.yaml.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"service": true,
		"serviceActivities": []interface{}{
			"grpc",
		},
		"grpcClients": []interface{}{
			"ruby",
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestReleaseRCForLibrary(t *testing.T) {
	st := stenciltest.New(t, ".releaserc.yaml.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"service": false,
		"grpcClients": []interface{}{
			"ruby",
		},
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderReadmeFile(t *testing.T) {
	st := stenciltest.New(t, "README.md.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"description": "My service",
	})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderPullRequestTemplateFile(t *testing.T) {
	st := stenciltest.New(t, ".github/pull_request_template.md.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{})
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderCodeownersFile(t *testing.T) {
	st := stenciltest.New(t, ".github/CODEOWNERS.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{
		"reportingTeam": "foo-bar",
	})
	st.Run(stenciltest.RegenerateSnapshots())
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
	st.Run(stenciltest.RegenerateSnapshots())
}

func TestRenderMiseTOML(t *testing.T) {
	st := stenciltest.New(t, "mise.toml.tpl", "_helpers.tpl")
	st.Args(map[string]interface{}{})
	st.Run(stenciltest.RegenerateSnapshots())
}
