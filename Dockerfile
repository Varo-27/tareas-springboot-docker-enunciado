FROM maven:3.9-eclipse-temurin-21 as compilador
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=compilador /app/target/* /app.jar
EXPOSE 9000
CMD [ "java", "-jar", "/app.jar" ]