# ===== Build stage =====
FROM maven:3-openjdk-17 AS build

WORKDIR /app

# Copy toàn bộ source code vào container
COPY . .

# Build project, bỏ qua test
RUN mvn clean package -DskipTests


# ===== Run stage =====
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy file WAR từ stage build sang
COPY --from=build /app/target/DrComputer-0.0.1-SNAPSHOT.war drcomputer.war

# Mở port ứng dụng
EXPOSE 8080

# Chạy ứng dụng Spring Boot
ENTRYPOINT ["java", "-jar", "drcomputer.war"]
