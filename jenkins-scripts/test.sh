echo "--- Logging into Docker Hub ---"
echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin

echo "--- Starting Smoke Test for image $DOCKER_USER/my-web-app:$IMAGE_TAG ---"

# Run the container in the background
CONTAINER_ID=$(docker run -d $DOCKER_USER/my-web-app:$IMAGE_TAG)

# Give the web server a moment to start
sleep 5

# --- ROBUST VERIFICATION STEP ---
echo "--- Verifying page content ---"
# This 'if' statement checks if the text is found. If not, it fails the job.
if docker exec $CONTAINER_ID curl -s http://localhost/ | grep -q "Orchestration Complete"; then
  echo "Content verification PASSED."
else
  echo "Content verification FAILED: Text not found!"
  # We get the content again just for the log output to see what went wrong.
  docker exec $CONTAINER_ID curl -s http://localhost/
  exit 1
fi

# Clean up the container
echo "--- Cleaning up test container ---"
docker stop $CONTAINER_ID
docker rm $CONTAINER_ID

echo "--- Smoke Test Passed ---"

