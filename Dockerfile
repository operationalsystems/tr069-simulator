FROM openjdk:8-jdk-alpine
ARG JAR_FILE

VOLUME /conf

# defaults for various configurations
# override at runtime by creating environment variables
ENV PI_INTERVAL 180
ENV SIMULATOR calix_ont
ENV CR_PORT 8035
ENV CR_PATH /
ENV AUTH_USER_NAME user
ENV AUTH_CREDENTIAL pass123!
ENV AUTH_TYPE basic
ENV ACS_URL http://localhost:8080/services/acs
ENV SERIAL_NUMBER_FMT CXNK%08d
ENV SERIAL_NUMBER 0
ENV IP_ADDRESS 127.0.0.1

RUN mkdir /app
RUN mkdir /dump

COPY target/$JAR_FILE /app/tr069-sim.jar
COPY simulator.yml /app
COPY dump/ /dump/

WORKDIR /app

ENTRYPOINT ["java", "-jar", "tr069-sim.jar", "server", "simulator.yml"]
