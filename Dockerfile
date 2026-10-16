# syntax=docker/dockerfile:1
# =============================================================================
#  Dockerfile - FILE KHUNG (multi-stage build cho Spring Boot 4 / Java 21 / Gradle)
#  Sinh viên hoàn chỉnh các ô ______ theo yêu cầu Phần 2 của đề thi.
# =============================================================================

# ---------- Stage 1: build - biên dịch & đóng gói bằng Gradle + JDK 21 ----------
#Base image có Gradle +JDK21(ví dụ gradel:8.14-jdk21-alpine) đặt tên là AS Build
#Copy build.gradle + settings.gradle trước, tải dependency để tận dụng cache, sau đó copy src/ và chạy thử bootJar -x test

# Spring Boot 4 yêu cầu Gradle >= 8.14
FROM gradle:8.14-jdk21-alpine AS build



# Copy build.gradle + settings.gradle trước, tải dependency để tận dụng cache layer
COPY build.gradle settings.gradle ./
RUN gradle dependencies

# Copy mã nguồn rồi đóng gói file JAR (bỏ qua test)
COPY src ./src
RUN gradle bootJar -x test

# ---------- Stage 2: runtime - chỉ chứa JRE 21 + file JAR ----------
# Base image chỉ có JRE 21 ( ví dụ eclipesetemurin:21-jre-alpine)
# Chỉ copy app.jar từ stage ( Copy --form=build ... ) chạy bằng user thường (non root)

#ARG APP_VERSION gán EVN APP_VERSION ( phiên bản của image), EXPOSE 8080 , ENTRYPOINT dạng exec
FROM openjdk:21-jre-alpine AS runtime

# Phiên bản ứng dụng truyền vào lúc build (docker compose: build-arg APP_VERSION)
ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION:-1.0.0}

WORKDIR /app

# Chạy ứng dụng bằng user thường, không dùng root
RUN addgroup -S spring && adduser -S spring -G spring
# Chỉ lấy file JAR từ stage build
COPY --from=build /app/build/libs/*.jar /app/app.jar
USER spring

EXPOSE 8080

# ENTRYPOINT dạng exec (mảng JSON)
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
