FROM openjdk:8-jdk-alpine

#RUN mkdir -p /opt/backend/

#COPY ./orders-api-0.0.1-SNAPSHOT.jar /opt/backend/orders-api.jar

RUN apk add git

RUN git clone https://github.com/ColadaFF/training-fs-backend.git orders-api

WORKDIR /orders-api

RUN ./mvnw -DskipTests clean package 

EXPOSE 8080

CMD ["java", "-jar", "-Dspring.profiles.active=prod", "/orders-api/target/orders-api-0.0.1-SNAPSHOT.jar"]