#!/bin/bash

# Update the system
sudo yum update -y

# Install required tools
sudo yum install wget unzip -y

# Install Java OpenJDK 11
sudo yum install java-11-openjdk-devel -y

# Add SonarQube user
sudo useradd -m -d /opt/sonarqube sonarqube

# Download and install SonarQube
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.7.0.61563.zip
sudo unzip sonarqube-9.7.0.61563.zip
sudo mv sonarqube-9.7.0.61563 sonarqube
sudo chown -R sonarqube:sonarqube /opt/sonarqube

# Configure SonarQube as a service
cat <<EOL | sudo tee /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonarqube
Group=sonarqube
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd daemon to apply changes
sudo systemctl daemon-reload

# Start and enable the SonarQube service
sudo systemctl start sonarqube
sudo systemctl enable sonarqube

# Allow SonarQube port through the firewall
sudo firewall-cmd --permanent --add-port=9000/tcp
sudo firewall-cmd --reload

# Ensure proper permissions
sudo chown -R sonarqube:sonarqube /opt/sonarqube
sudo chmod -R 755 /opt/sonarqube

# Verify the service status without blocking the script
sudo systemctl is-active --quiet sonarqube && echo "SonarQube is running" || echo "SonarQube failed to start"

# Display troubleshooting information if the service failed to start
if ! sudo systemctl is-active --quiet sonarqube; then
    echo "Failed to start sonar...."
    sudo journalctl -xeu sonarqube.service
fi

echo "SonarQube installation script completed. Access it at http://<your-server-ip>:9000"
