{{- /* Only render markdown if forced, or if we're a service */}}
{{- if or (not (stencil.Arg "forceRenderMarkdown")) (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: {{ .Config.Name }} New Bento Instructions 🧊 -->

# {{ .Config.Name }} New Bento Instructions

To deploy your service to a new NGB bento:

1. Create a new git branch.
2. Add a new list entry with the bento name and channel to `deployTo.additionalBentos` in `service.yaml`:

```yaml
deployTo:
  additionalBentos:
    - name: bentoname99z
      channel: chartreuse
```

3. Re-run `bootstrap` so that the any per-bento configuration provided by Bootstrap
   (e.g., deployments, monitoring) are updated with the new bento.
4. Create a new pull request for your repository with the branch. An example pull request title:
   `feat: add bentoname99z to deployed bentos`
5. When the pull request is approved, apply any changes via Atlantis and Mozart as necessary.
6. Merge the pull request.

<!--- Block(customNewBentoDocumentation) -->
{{ file.Block "customNewBentoDocumentation" }}
<!--- EndBlock(customNewBentoDocumentation) -->
