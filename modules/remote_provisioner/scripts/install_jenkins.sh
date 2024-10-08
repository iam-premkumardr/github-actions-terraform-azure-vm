#!/bin/bash

# Update package information
sudo apt-get update -y

# Install Java (required by Jenkins)
sudo apt-get install -y openjdk-11-jdk

# Add Jenkins repository and key
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# Create Jenkins source list
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update package information with the new Jenkins repo
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Print initial admin password
echo "Jenkins installed. Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
