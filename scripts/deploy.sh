#!/bin/bash

# Navigate to the app directory
cd /home/ec2-user/app

# Stop any existing running Java processes
echo "Stopping existing Java app if it's running..."
ps aux | grep 'DevOpsSummative-1.0-SNAPSHOT.jar' | grep -v grep | awk '{print $2}' | xargs -r kill -9

# Make the JAR file executable (if it exists)
if [ -f DevOpsSummative-1.0-SNAPSHOT.jar ]; then
  echo "Setting executable permissions on the JAR..."
  chmod +x DevOpsSummative-1.0-SNAPSHOT.jar || echo "Warning: Could not change permissions on JAR file"
else
  echo "Error: JAR file not found!"
  exit 1
fi

# Start the new Java app in the background
echo "Starting new Java app..."
nohup java -jar DevOpsSummative-1.0-SNAPSHOT.jar > app.log 2>&1 &

# Wait a few seconds for the app to start
sleep 5

# Validate the app
echo "Validating the service..."
curl -f http://localhost:8080 || exit 1

echo "Deployment completed successfully."
