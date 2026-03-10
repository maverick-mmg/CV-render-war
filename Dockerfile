FROM eclipse-temurin:21-jdk AS check

WORKDIR /check
COPY dist/CV.war ./CV.war

# Vérifie que le fichier est bien un vrai WAR exploitable
RUN ls -lh CV.war
RUN jar tf CV.war > /tmp/war-list.txt
RUN grep -q "index.jsp" /tmp/war-list.txt
RUN grep -q "WEB-INF/classes/controller/ConversionServlet.class" /tmp/war-list.txt

FROM tomcat:10.1-jre21-temurin

WORKDIR /usr/local/tomcat
RUN rm -rf webapps/*

COPY --from=check /check/CV.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 10000

CMD ["sh", "-c", "sed -i \"0,/port=\\\"8080\\\"/s//port=\\\"${PORT:-10000}\\\"/\" conf/server.xml && catalina.sh run"]
