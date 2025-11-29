# Multi-stage build for Spring Boot application
# Stage 1: Build
FROM eclipse-temurin:21-jdk-jammy AS builder

WORKDIR /build

# Copy Maven wrapper and POM
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

# Make mvnw executable
RUN chmod +x mvnw

# Copy source code
COPY src src

# Build the application (skip tests for faster builds)
RUN ./mvnw clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copy built JAR from builder stage
COPY --from=builder /build/target/*.jar app.jar

# Expose port (default Spring Boot port)
EXPOSE 8080

# Health check (use runtime $PORT so container healthcheck matches the app port)
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD ["sh","-c","curl -f http://localhost:$PORT/actuator/health || exit 1"]

# Set environment variables (can be overridden at runtime)
ENV PORT=8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
CMD []
