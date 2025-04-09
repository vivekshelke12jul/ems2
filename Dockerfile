# Use an official OpenJDK 17 base image
FROM amazoncorretto:21-alpine-jdk AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the source code and build files
COPY . .

RUN chmod +x ./gradlew
# Build the Spring Boot application using Gradle (Change if using Maven)
RUN ./gradlew clean build

# Use a smaller runtime image for production
FROM gradle:8.12.1-jdk21-alpine
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]