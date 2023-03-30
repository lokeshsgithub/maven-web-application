FROM tomcat:8.0.15-jre7
COPY target/maven-web-application*.war /use/local/tomcat/webapps/maven-web-application.war
