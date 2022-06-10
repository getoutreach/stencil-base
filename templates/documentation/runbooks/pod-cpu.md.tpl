{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: Runbooks 🧊 -->
<!-- Title: Pod CPU 🧊 -->

# {{ camelcase .Config.Name }} Pod CPU > \<threshold\>% of request last \<window\>m

[Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard]({{ $dashboard }}) and find the "Total CPU" monitor under
the "Deployment" pane. Zero-in on a time frame where CPU spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

<!--- Block(podCPUSpike) -->
{{ file.Block "podCPUSpike" }}
<!--- EndBlock(podCPUSpike) -->
