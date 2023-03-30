FROM tomcat:7.0.57-jre7
COPY target/maven-web-application*.war /usr/local/tomcat/webapp/maven-web-application.war
