{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- $http := (has "http" (stencil.Arg "serviceActivities")) }}
{{- $grpc := (has "grpc" (stencil.Arg "serviceActivities")) }}
{{- $dashboard := stencil.Arg "datadogDashboards.mainLink" }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Title: Runbooks 🧊 -->

# {{ .Config.Name }} Runbooks

## Index of Runbooks

* [Avaliable Pods Low](./runbooks/available-pods-low.md)
* [Pod CPU > \<threshold\>% of request last \<window\>m](./runbooks/pod-cpu.md)
* [Pod Memory.\<type\> > 80% of limit last 30m](./runbooks/pod-memory.md)
* [Pod Restarts > \<threshold\> last 30m](./runbooks/pod-restarts.md)
* [Service Panics](./runbooks/service-panics.md)
{{- if $http }}
* [HTTP Latency High](./runbooks/http-latency-high.md)
* [HTTP Success Rate Low](./runbooks/http-success-rate-low.md)
{{- end }}
{{- if $grpc }}
* [gRPC Latency High](./runbooks/grpc-latency-high.md)
* [gRPC Success Rate Low](./runbooks/grpc-success-rate-low.md)
{{- end }}
<!--- Block(additionalRunbookLinks) -->
{{ file.Block "additionalRunbookLinks" }}
<!--- EndBlock(additionalRunbookLinks) -->

## General Debugging

### Kubernetes Resources

To view all of the kubernetes resources created by {{ .Config.Name }}, use the following command after
switching into the appropriate context using `orc context`:

```shell
kubectl -n {{ .Config.Name }}--<bento> get all
```

<!--- Block(generalDebugging) -->
{{ file.Block "generalDebugging" }}
<!--- EndBlock(generalDebugging) -->
