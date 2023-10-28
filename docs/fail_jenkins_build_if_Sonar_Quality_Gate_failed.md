<img src="../images/c4logo.png">

### Fail the jenkins build if SonarQube Quality Gate get Failed.

1. In order to perform this we have to install the required pluins.

    * SonarQube Scanner
    * Sonar Quality Gates

2. To configure the **Quality Gates - Sonarqube**, navigate to 

    Jenkins Dashboard >> Manage Jenkins >> Configure System >> Under SonarQube servers, click on **Add Sonar Qube** Provide name and Sonar server URL with Server Authentication Token. 

    Once you mention, please look for **Quality Gates - Sonarqube** and click on **Add Sonar Instance**, provide name, Sonar Quber Server URL, Sonarqube Account token, Sonar Qube Account Login, Sonar Qube Account Password. 

    Now click on **Apply** and **Save**

3. Click on your jenkins job and click on **Configure**, Under **Post-build Actions** select **Quality Gates Sonarqube Plugin**,  
   provide your **Project key** and job status when analysis fails section select **FAILED**
    
4. Now click on **Apply** and **save**

5. Before trigger a build we have to chage the code so that we can test whether our configuration is working or not, to do so
   open you index.jsp file and copy the contents of **<body> ... </body>** two or three times. save the file on git

6. Now Trigger a build and check the job has failed as the SonarQube quality gates status failed.   