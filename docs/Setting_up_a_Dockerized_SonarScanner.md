<img src="../images/c4logo.png">

### Steps:
1. Login to your Linux VM and [Install docker](https://github.com/c4clouds/docker-tutorials/edit/master/install_docker_centos7.md).

2. Create a Docker Volume to persist Sonar data
    * docker volume create sonar-data

3. Launch Sonar Docker Container with below command
    * docker run -d --name sonarqube -p 9000:9000 -v sonar-data:/opt/sonarqube/conf -v sonar-data:/opt/sonarqube/data -v sonar-data:/opt/sonarqube/logs -v sonar-data:/opt/sonarqube/extensions sonarqube

This will start your sonar server on port 9000. After a few minutes, open the URL **Linux_Host_IP:9000**. There you will be asked to log in, and the default **username and password is admin**.

