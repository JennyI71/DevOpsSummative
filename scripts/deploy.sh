#!/bin/bash

# Navigate to the app directory
cd /home/ec2-user/app

# Stop any existing running Java processes
echo "Stopping existing Java app if it's running..."
ps aux | grep 'java' | grep 'DevOpsSummative-1.0-SNAPSHOT.jar' | awk '{print $2}' | xargs kill -9

# Make the JAR file executable
chmod +x DevOpsSummative-1.0-SNAPSHOT.jar

# Start the new Java app in the background
echo "Starting new Java app..."
nohup java -jar DevOpsSummative-1.0-SNAPSHOT.jar > app.log 2>&1 &

# Optionally, you can add additional steps like logging, monitoring, etc.
echo "Deployment completed successfully."
