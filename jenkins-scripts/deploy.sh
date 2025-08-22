echo "--- Starting Kubernetes Deployment ---"

# The KUBECONFIG variable is automatically used by kubectl if needed,
# but this job runs locally on the K8s node, so it's not required.
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-web-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-web-app
  template:
    metadata:
      labels:
        app: my-web-app
    spec:
      containers:
      - name: my-web-container
        image: abhaydocker732/my-web-app:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 80
EOF

echo "--- Deployment Manifest Applied ---"

echo "--- Forcing a rolling restart of the deployment ---"
kubectl rollout restart deployment my-web-app

