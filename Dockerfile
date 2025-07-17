# 1. Maven ile uygulamayı build et
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# 2. Tomcat imajına geç
FROM tomcat:9.0-jdk17

# 3. War dosyasını Tomcat webapps klasörüne kopyala
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/hello.war

# 4. Tomcat 8080 portunu dışa aç
EXPOSE 8080

# 5. Tomcat başlat
CMD ["catalina.sh", "run"]
