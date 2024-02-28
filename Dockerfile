# Use the official Tomcat image
FROM tomcat:latest

COPY swe645.war /usr/local/tomcat/webapps/

# Exose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
