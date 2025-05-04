#!/bin/bash

set -e

APP_DIR="/home/ec2-user/app"
JAR_NAME="DevOpsSummative-1.0-SNAPSHOT.jar"

echo "Navigating to app directory: $APP_DIR"
cd "$APP_DIR"

echo "Stopping existing Java app if it's running..."
PIDS=$(ps aux | grep "$JAR_NAME" | grep -v grep | awk '{print $2}')
if [ -n "$PIDS" ]; then
  echo "Found running process(es): $PIDS"
  kill -9 $PIDS || echo "Warning: Failed to kill process(es)"
else
  echo "No existing Java process found."
fi

if [ ! -f "$JAR_NAME" ]; then
  echo "ERROR: JAR file not found in $APP_DIR!"
  exit 1
fi

echo "Setting executable permission on JAR..."
chmod +x "$JAR_NAME" || echo "Warning: chmod failed"

echo "Starting the new Java app..."
nohup java -jar "$JAR_NAME" > app.log 2>&1 &

# Wait for the app to actually start
echo "Waiting for the app to start..."
for i in {1..10}; do
  sleep 2
  if curl -s http://localhost:8080 > /dev/null; then
    echo "Application is up!"
    break
  fi
  echo "Waiting... attempt $i"
  if [ "$i" -eq 10 ]; then
    echo "ERROR: Application failed to start."
    exit 1
  fi
done

echo "Deployment completed successfully."
