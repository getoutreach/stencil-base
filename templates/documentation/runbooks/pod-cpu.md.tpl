{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
{{- $dashboard := stencil.Arg "datadogDashboards.mainLink" }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} Pod CPU 🧊 -->

# {{ camelcase .Config.Name }} Pod CPU > \<threshold\>% of request last \<window\>m

CPU high alerts will occur if the CPU rate is too high over x amount of time. The net impact is that customers might start seeing failures in {{ camelcase .Config.Name }} requests. On the other hand, none of the above might actually happen and the CPU usage might drop down on it’s own. If the High CPU usage keeps repeating for the same host, there might be something wrong with the host itself and it might need recycling - all of this is described in much more detail below.

<!--- Block(podCPUSpikeOverview) -->
{{ file.Block "podCPUSpikeOverview" }}
<!--- EndBlock(podCPUSpikeOverview) -->

## Investigation

### Datadog Dashboard and Logs

[Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard]({{ $dashboard }}) and find the "Total CPU" monitor under
the "Deployment" pane. Zero-in on a time frame where CPU spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

Look for any anomalies in the dashboard.

{{ camelcase .Config.Name }} logs are available via a search: https://app.datadoghq.com/logs/livetail?query=service%3A{{ .Config.Name }}%20environment%3Aproduction%20status%3Aerror&index=main&from_ts=1652033594145&to_ts=1652206394145&live=true. Modify the search parameters to match the bento and environment the alert was generated from.

Look for signs of issues or abnormal behavior.

<!--- Block(podCPUSpikeDatadog) -->
{{ file.Block "podCPUSpikeDatadog" }}
<!--- EndBlock(podCPUSpikeDatadog) -->

### Honeycomb

If there are a large volume of requests with triggering the issue some information on the details of the requests may be available in Honeycomb. Note that honeycomb samples requests (usually with a low sampling rate of 1%) so for low frequency issues the odds of finding something in Honeycomb are low.

You can use the following as a starter Honeycomb query to begin looking for traces that exhibit the performance problems you are investigating.

<!--- Block(ggrpcSuccessRateLowHoneycomb)) -->
{{ file.Block "grpcSuccessRateLowHoneycomb)" }}
<!--- EndBlock(grpcSuccessRateLowHoneycomb)) -->

### Check the Pod CPU Usage Directly

You can get a real time view of current CPU utilization in the cluster by running the following command:

`kubectl --context <context> -n {{ .Config.Name }}--<bento> top pod`

Substitute the appropriate values for `<context>` and `<bento>` based on the environment and bento you want to modify. Refer to [Deployments](/documentation/deployments.md) for a mapping from bento to context.

The output of the top command will show the current CPU and memory usage for all of the pods running in the cluster. Look for pods with abnormally high values. You can view the logs for specific pods with the following command:

`kubectl --context <context> -n {{ .Config.Name }}--<bento> log <pod_name>`

where `<pod_name>` is the name of the pod exhibiting abnormal CPU usage.

<!--- Block(podCPUSpikeDirect) -->
{{ file.Block "podCPUSpikeDirect" }}
<!--- EndBlock(podCPUSpikeDirect) -->

## Resolution

<!--- Block(podCPUSpikeResolution) -->
{{ file.Block "podCPUSpikeResolution" }}
<!--- EndBlock(podCPUSpikeResolution) -->

<!--- Block(podCPUSpike) -->
{{ file.Block "podCPUSpike" }}
<!--- EndBlock(podCPUSpike) -->
