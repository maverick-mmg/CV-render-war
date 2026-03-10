FROM tomcat:10.1.24-jdk21-temurin

WORKDIR /usr/local/tomcat

RUN rm -rf /usr/local/tomcat/webapps/*
COPY dist/CV.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 10000

CMD ["sh", "-c", "sed -i \"0,/port=\\\"8080\\\"/s//port=\\\"${PORT:-10000}\\\"/\" conf/server.xml && catalina.sh run"]
