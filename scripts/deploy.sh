#!/bin/bash
cd /home/ec2-user/app
chmod +x DevOpsSummative-1.0-SNAPSHOT.jar
nohup java -jar DevOpsSummative-1.0-SNAPSHOT.jar > app.log 2>&1 &
