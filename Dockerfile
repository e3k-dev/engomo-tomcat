FROM tomcat:9

#setup server.xml
ADD ./server.xml /usr/local/tomcat/conf/

#context.xml contains jndi connection to demo-database
ADD ./context.xml $CATALINA_HOME/conf/

#mysql driver jar
ADD ./mysql-connector-java-8.0.22.jar $CATALINA_HOME/lib/

#engomo.war
ADD ./engomo.war /usr/local/tomcat/webapps/

# Solution for "PKIX path building failed" and "unable to find valid certification path to requested target"
# See: https://stackoverflow.com/questions/21076179/pkix-path-building-failed-and-unable-to-find-valid-certification-path-to-requ

ADD ./license.engomo-e3k.cer /
RUN yes changeit | keytool -import -alias license.engomo-e3k.cer -keystore /usr/local/openjdk-11/lib/security/cacerts -trustcacerts -noprompt -file /license.engomo-e3k.cer
