{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- $dashboard := stencil.Arg "datadogDashboards.mainLink" }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} Pod Memory 🧊 -->

# {{ camelcase .Config.Name }} Pod Memory.\<type\> > 80% of limit last 30m

[Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard]({{ $dashboard }}) and find the "Total Memory" monitor under
the "Deployment" pane. Zero-in on a time frame where memory spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

<!--- Block(podMemorySpike) -->
{{ file.Block "podMemorySpike" }}
<!--- EndBlock(podMemorySpike) -->
