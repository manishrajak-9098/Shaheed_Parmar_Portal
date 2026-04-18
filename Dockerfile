# Step 1: Build phase
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Runtime phase (Tomcat 10 for Jakarta EE)
FROM tomcat:10.1-jdk17-openjdk-slim

# Important: Render needs to know which port to use. 
# Tomcat defaults to 8080, but we want to be explicit.
ENV PORT=8080

# Remove default apps to avoid memory waste and conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file. 
# We rename it to ROOT.war so your website lives at the "root" (/)
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
