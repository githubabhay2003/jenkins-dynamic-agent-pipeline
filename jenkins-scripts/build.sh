echo "--- 1. Building Docker Image ---"
docker build -t my-web-app .

echo "--- 2. Tagging Docker Image with Build Number and Latest ---"
# Tag with the unique build number for version history
docker tag my-web-app $DOCKER_USER/my-web-app:$BUILD_NUMBER
# Also tag with 'latest' for the deployment job
docker tag my-web-app $DOCKER_USER/my-web-app:latest

echo "--- 3. Logging into Docker Hub ---"
echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin

echo "--- 4. Pushing Both Tags to Docker Hub ---"
docker push $DOCKER_USER/my-web-app:$BUILD_NUMBER
docker push $DOCKER_USER/my-web-app:latest

