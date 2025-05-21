helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install tempo grafana/tempo-distributed \
  --namespace observability --create-namespace \
  --set metricsGenerator.enabled=true \
  --set traces.otlp.grpc.enabled=true \
  --set traces.otlp.http.enabled=true

helm upgrade tempo grafana/tempo-distributed \
  --namespace observability \
  --install \
  --set metricsGenerator.enabled=true \
  --set traces.otlp.grpc.enabled=true \
  --set traces.otlp.http.enabled=true \
  --set distributor.service.type=NodePort \
  --set distributor.service.ports[0].name=http-metrics \
  --set distributor.service.ports[0].port=3100 \
  --set distributor.service.ports[0].targetPort=3100 \
  --set distributor.service.ports[0].nodePort=31119 \
  --set distributor.service.ports[1].name=grpc \
  --set distributor.service.ports[1].port=9095 \
  --set distributor.service.ports[1].targetPort=9095 \
  --set distributor.service.ports[1].nodePort=31175 \
  --set queryFrontend.service.type=NodePort \
  --set queryFrontend.service.ports[0].name=http-metrics \
  --set queryFrontend.service.ports[0].port=3100 \
  --set queryFrontend.service.ports[0].targetPort=3100 \
  --set queryFrontend.service.ports[0].nodePort=32413 \
  --set queryFrontend.service.ports[1].name=grpc \
  --set queryFrontend.service.ports[1].port=9095 \
  --set queryFrontend.service.ports[1].targetPort=9095 \
  --set queryFrontend.service.ports[1].nodePort=31734


# 방화벽 허용

```
# 노드 Port 허용으로 변경
sudo iptables -A INPUT -p tcp --dport 4317 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 4318 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 3100 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 3200 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT


sudo iptables -A INPUT -p tcp --dport 30885 -j ACCEPT
```

# 저장 (시스템에 따라 다를 수 있음)
sudo netfilter-persistent save
sudo iptables-save | sudo tee /etc/iptables/rules.v4 > /dev/null

# 조회 
sudo cat /etc/iptables/rules.v4
sudo iptables -L INPUT -n | grep 32413

# k9s issue
sudo ln -s /snap/bin/microk8s.kubectl /usr/local/bin/kubectl
echo 'export EDITOR=vi' >> ~/.bashrc