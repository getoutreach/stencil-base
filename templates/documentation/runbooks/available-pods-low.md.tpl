{{- if not (stencil.Arg "service") }}
{{- file.Skip "project is not a service" }}
{{- end }}
<!-- Space: {{ stencil.Arg "opslevel.confluenceSpaceKey" }} -->
<!-- Parent: Service Documentation 🧊 -->
<!-- Parent: {{ .Config.Name }} 🧊 -->
<!-- Parent: {{ .Config.Name }} Runbooks 🧊 -->
<!-- Title: {{ .Config.Name }} Available Pods Low 🧊 -->

# {{ camelcase .Config.Name }} Available Pods Low

List the pods in the bento that the alert fired in for this service:

```shell
kubectl -n {{ .Config.Name }}--<bento> get pods
```

It's likely that some number of service pods are in an unhealthy state, describe them:

```shell
kubectl -n {{ .Config.Name }}--<bento> describe pod <pod name>
```

Look at the events and last known state when describing the pods, one of these areas should lead in the
correct direction of the source of the problem. It may also be a useful exercise to peek at the deployment:

```shell
kubectl -n {{ .Config.Name }}--<bento> describe deployment {{ .Config.Name }}
```

<!--- Block(availablePodsLow) -->
{{ file.Block "availablePodsLow" }}
<!--- EndBlock(availablePodsLow) -->
