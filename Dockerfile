# Step 1: Build the WAR file using Maven
FROM maven:3.8.4-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the WAR file in Tomcat
FROM tomcat:10.1-jdk17-openjdk-slim
# Purane apps ko hata kar apna app ROOT.war naam se dalein
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]