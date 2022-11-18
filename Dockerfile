# syntax = docker/dockerfile:1.3

ARG BASE_IMAGE=eclipse-temurin:8-jre-focal
FROM ${BASE_IMAGE}

EXPOSE 80 443

VOLUME ["/data"]
WORKDIR /data

ARG EAGLERCRAFT_BASE_URL=https://github.com/gunawan092w/eaglercraft
RUN curl -fsSL ${EAGLERCRAFT_BASE_URL}/archive/refs/heads/main.tar.gz \
    | tar -C /data/eaglercraft -zxf -

ARG MIN_RAM=512M
ARG MAX_RAM=512M
RUN java -Xms${MIN_RAM} -Xmx${MAX_RAM} -jar /data/eaglercraft/stable-download/java/bukkit_command/craftbukkit-1.5.2-R1.0.jar

# We manually set the RAM here since it doesn't matter
RUN java -Xms32M -Xmx32M -jar /data/eaglercraft/stable-download/java/bungee_command/bungee-dist.jar