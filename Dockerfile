FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY app/target/aws-cicd-app-1.0.0.jar app.jar
CMD ["java", "-jar", "app.jar"]
