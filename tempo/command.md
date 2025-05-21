	@helm repo add grafana https://grafana.github.io/helm-charts && \
	helm repo update && \
	helm upgrade --install tempo grafana/tempo \
	-n observability --create-namespace \
	-f tempo/tempo-values-override.yaml	
    