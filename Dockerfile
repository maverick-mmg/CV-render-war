FROM tomcat:10.1.24-jdk21-temurin

WORKDIR /usr/local/tomcat

RUN rm -rf webapps/*
COPY dist/CV.war /usr/local/tomcat/webapps/ROOT.war

# Permissions compatibles OpenShift
RUN chgrp -R 0 /usr/local/tomcat && chmod -R g=u /usr/local/tomcat

EXPOSE 8080

CMD ["catalina.sh", "run"]
