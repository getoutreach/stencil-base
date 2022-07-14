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

Memory high alerts will occur if the memory rate is too high over x amount of time. The net impact is that customers might start seeing failures in {{ camelcase .Config.Name }} requests. On the other hand, none of the above might actually happen and the memory usage might drop down on its own. If the High Memory usage keeps repeating for the same host, there might be something wrong with the host itself and it might need recycling - all of this is described in much more detail below.

## Investigation

### Datadog Dashboard and Logs

[Navigate to the `Terraform: {{ camelcase .Config.Name }}` dashboard]({{ $dashboard }}) and find the "Total Memory" monitor under
the "Deployment" pane. Zero-in on a time frame where memory spiked, note that time frame, and change the window of
the dashboard to that time frame. Correlate any other useful monitors to see what could be causing this - look at
various sources of traffic like gRPC or HTTP. Looking at logs at the same time frame may also be useful using the
`kube_namespace:{{ .Config.Name }}--<bento>` facet.

Also look at the [trending memory dashboard](https://app.datadoghq.com/dashboard/i6z-jcn-azh/terraform-{{ .Config.Name }}?fullscreen_end_ts=1642528770105&fullscreen_paused=false&fullscreen_section=overview&fullscreen_start_ts=1641923970105&fullscreen_widget=5625648833266685&from_ts=1641923966020&to_ts=1642528766020&live=true) in DataDog.

Additional {{ camelcase .Config.Name }} logs are available via a search: https://app.datadoghq.com/logs/livetail?query=service%3A{{ .Config.Name }}%20environment%3Aproduction%20status%3Aerror&index=main&from_ts=1652033594145&to_ts=1652206394145&live=true. Modify the search parameters to match the bento and environment the alert was generated from.

<!--- Block(podMemorySpikeDatadog) -->
{{ file.Block "podMemorySpikeDatadog" }}
<!--- EndBlock(podMemorySpikeDatadog) -->

### Honeycomb

If there are a large volume of requests with triggering the issue some information on the details of the requests may be available in Honeycomb. Note that honeycomb samples requests (usually with a low sampling rate of 1%) so for low frequency issues the odds of finding something in Honeycomb are low.

[Navigate to Honeycomb](https://ui.honeycomb.io/outreach-a0/datasets/outreach?query=%7B%22time_range%22%3A7200%2C%22granularity%22%3A0%2C%22breakdowns%22%3A%5B%22name%22%5D%2C%22calculations%22%3A%5B%7B%22op%22%3A%22P95%22%2C%22column%22%3A%22duration_ms%22%7D%2C%7B%22op%22%3A%22HEATMAP%22%2C%22column%22%3A%22duration_ms%22%7D%5D%2C%22filters%22%3A%5B%7B%22column%22%3A%22app.name%22%2C%22op%22%3A%22%3D%22%2C%22value%22%3A%22{{ .Config.Name }}%22%7D%5D%2C%22filter_combination%22%3A%22AND%22%2C%22orders%22%3A%5B%7B%22column%22%3A%22duration_ms%22%2C%22op%22%3A%22P95%22%2C%22order%22%3A%22descending%22%7D%5D%2C%22havings%22%3A%5B%5D%2C%22limit%22%3A1000%7D) 
and add `deployment.namespace = {{ .Config.Name }}--<bento>` to the `WHERE` clause, where `<bento>` is the bento that
this alert fired in. These traces may provide an idea as to what could be the root cause of the errors.

<!--- Block(podMemorySpikeHoneycomb) -->
{{ file.Block "podMemorySpikeHoneycomb" }}
<!--- EndBlock(podMemorySpikeHoneycomb) -->

## Resolution

Once you determine what the errors are, they fall usually fall into one of several categories categories:

1. Too many requests: If the number of requests drops, then the service should recover on it’s own.

2. Hardware error: The solution is to restart the pod. The simplest way to due this is by triggering a new deployment with:

```shell
kubectl --context <context> -n {{ .Config.Name }}--<bento> patch deployment {{ .Config.Name }} -p "{\"spec\": {\"template\": {\"metadata\": { \"labels\": { \"redeploy\": \"$(date +%s)\"}}}}}"
```

Substitute the appropriate values for `<context>` and `<bento>` based on the environment and bento you want to modify. Refer to [Deployments](/documentation/deployments.md) for a mapping from bento to context.

Verify the pods are cycling by executing:

```shell
kubectl --context <context> -n {{ .Config.Name }}--<bento> get pods
```

and verifying the pods are restarting, or recently restarted.

<!--- Block(podMemorySpikeResolution) -->
{{ file.Block "podMemorySpikeResolution" }}
<!--- EndBlock(podMemorySpikeResolution) -->

<!--- Block(podMemorySpike) -->
{{ file.Block "podMemorySpike" }}
<!--- EndBlock(podMemorySpike) -->
