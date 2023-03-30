FROM 8.0.15-jre7
COPY target/maven-web-application*.war /usr/local/tomcat/webapps/mavenwebapplication.war
