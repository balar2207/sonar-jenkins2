<img src="../images/c4logo.png">

### Steps:
1. Login to your Linux VM and [Install docker](https://github.com/c4clouds/docker-tutorials/edit/master/install_docker_centos7.md).

2. Create Two Docker Volumes to persist Jenkins and Sonar data
    
    * docker volume create sonar-data
    
    * docker volume create jenkins-data

3. Launch Container based Sonar [Click Here to see the steps](https://github.com/c4clouds/sonar-jenkins/blob/main/docs/ting_up_a_Dockerized_SonarScanner.md)

4. Launch Container based Jenkins with below command.

    * docker run -d -p 8080:8080 -p 50000:50000 --name=jenkins -v jenkins-data:/var/jenkins_home jenkins/jenkins:lts

    #### To get the login password

    * cat /var/lib/docker/volumes/jenkins-data/_data/secrets/initialAdminPassword

5. To access jenkins Web UI Navigate to linux_Host_IP:8080. Default UserName is **admin** and Password is **refer To get the login password**

6. To Install the SonarScanner Pluging, Navigateto 
   
   Manage Jenkins >> Manage Plugins >> Available Tab >> Search for **SonarQube Scanner** >> Install the Plugin >> restart the Jenkins.

7. Login to SonarServer and generate a Token.   

8.  To Configure Sonar server on Jenkins, navigate to 
    Manage Jenkins >> Configuration >> SonarQube servers >> provide a Name and SonarServer URL with Port Number.

    * Configure Server Authentication Token on jenkins, add the created token on jenkins   

9. Add SonarQube Scanner on jenkins, Navigate to 

   * Jenkins Dashboard >> Manage Jenkins >> Global Tools Configuration >> Add SonarQube Scanner, give a name **sonar-demo**, click on the **Install Automaticall** check box, select latest SonarQube Scanner version. >> click on Apply and Save.Under Source Code      

9. Create a Jenkins Job for Sonar-Jenkins Integration.

    On the Jenkins Dashboard >> New Item >> Give Name to Youre Jenkins Job >> Click on Free Style Project >> Clck on OK.

10. Under Source Code  Management select **git** Repository and Provide the Github Codebase URL.

    * You can use the same Maven-HelloWorld project for the demo here is the git URL
    **https://github.com/c4clouds/maven-helloworld.git**

    * On Build section select **Execute SonarQube Scanner** and in the **Analysis properties** provide the below code
    ```
    sonar.projectKey=my:project
    sonar.projectName=My project
    sonar.projectVersion=1.0
    sonar.sources=.
    ```

11. Trigger jenkins build.
