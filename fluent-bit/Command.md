helm show values fluent/fluentd
k create ns logging
helm upgrade --install fluent-bit fluent/fluent-bit -n logging -f values.yaml
```
Release "fluent-bit" does not exist. Installing it now.
NAME: fluent-bit
LAST DEPLOYED: Thu Mar 20 12:30:17 2025
NAMESPACE: logging
STATUS: deployed
REVISION: 1
NOTES:
Get Fluent Bit build information by running these commands:

export POD_NAME=$(kubectl get pods --namespace logging -l "app.kubernetes.io/name=fluent-bit,app.kubernetes.io/instance=fluent-bit" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace logging port-forward $POD_NAME 2020:2020
curl http://127.0.0.1:2020
```

{ "@timestamp": [ "2025-03-27T04:17:09.537Z" ], "_id": "sunR1ZUBhDRKAW1-ehb4", "_index": "kubernetes-logs", "_p": "F", "_type": null, "caller": "service_controller.go:60", "controller": "ServiceReconciler", "highlight": null, "kubernetes": { 
    "annotations": { "prometheus.io/port": "7472", "prometheus.io/scrape": "true" }, 
    "container_hash": "quay.io/metallb/speaker@sha256:839ca1f96149ec65b3af5aa20606096bf1bd7d43727611a5ae16de21e0c32fcd", 
    "container_image": "quay.io/metallb/speaker:v0.13.3", "container_name": "speaker", "docker_id": "b0d5cbfc8e92d8d7344157645e4ae5a3bb04858e81cc955aab6b8bbfb6b7f92b", "host": "instance-20250313-1728", "labels": { "app": "metallb", "component": "speaker", "controller-revision-hash": "79f47fdf97", "pod-template-generation": "1" }, "namespace_name": "metallb-system", "pod_id": "c33bf4d7-89c7-4d24-aae6-a8c89fbfe937", "pod_ip": "10.0.0.197", "pod_name": "speaker-z76bk" }, "level": "info", "sort": [ 1743049029537, 1870 ], "start reconcile": "kube-system/microk8s.io-hostpath", "stream": "stdout", "time": "2025-03-27T04:17:09.537812327Z", "ts": "2025-03-27T04:17:09Z" }
