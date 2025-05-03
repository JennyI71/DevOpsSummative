#!/bin/bash

# Install dependencies
echo "Installing Java 17..."
sudo yum install -y java-17-amazon-corretto

# Navigate to the app directory
mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

# Stop any existing running Java processes
echo "Stopping existing Java app if it's running..."
ps aux | grep 'DevOpsSummative-1.0-SNAPSHOT.jar' | grep -v grep | awk '{print $2}' | xargs -r kill -9

# Move the JAR file if needed
echo "Moving new JAR file..."
cp /home/ec2-user/scripts/DevOpsSummative-1.0-SNAPSHOT.jar .

# Make the JAR file executable
chmod +x DevOpsSummative-1.0-SNAPSHOT.jar

# Start the new Java app in the background
echo "Starting new Java app..."
nohup java -jar DevOpsSummative-1.0-SNAPSHOT.jar > app.log 2>&1 &

# Validate the app
echo "Validating the service..."
curl -f http://localhost:8080 || exit 1

echo "Deployment completed successfully."
