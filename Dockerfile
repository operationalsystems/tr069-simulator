FROM openjdk:8-jdk-alpine
ARG JAR_FILE
ARG SIMULATOR

VOLUME /conf

RUN mkdir /app
RUN mkdir /dump

COPY target/$JAR_FILE /app/tr069.jar
COPY simulator.yml /app
COPY dump/$SIMULATOR/cpekeys.properties /dump
COPY dump/$SIMULATOR/getnames.txt /dump
COPY dump/$SIMULATOR/getvalues.txt /dump

WORKDIR /app

ENTRYPOINT ["java", "-jar", "tr069.jar", "server", "simulator.yml"]
