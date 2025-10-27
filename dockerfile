# =========================
# Stage 1: Build the JAR
# =========================
FROM maven:3.9.9-eclipse-temurin-25 AS builder

# Set working directory
WORKDIR /app

# Copy only the pom.xml first (for dependency caching)
COPY pom.xml .

# Download project dependencies (cached layer)
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the Spring Boot JAR (skip tests for faster builds)
RUN mvn clean package -DskipTests

# =========================
# Stage 2: Run the app
# =========================
FROM eclipse-temurin:25-jdk-jammy

# Set working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Set the default profile (optional)
ENV SPRING_PROFILES_ACTIVE=prod

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
