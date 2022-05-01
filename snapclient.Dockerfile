FROM debian:buster-slim

LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.26.0

RUN apt update && \
        apt upgrade -y && \
        # apt install wget ca-certificates -y --no-install-recommends && \
        # apt install -y libsdl2-dev && \
        wget https://github.com/badaix/snapcast/releases/download/v$snapcast_version/snapclient_$snapcast_version-1_amd64.deb && \
        apt -f install -y ./snapclient_$snapcast_version-1_amd64.deb && \
        # apt remove --purge -y wget ca-certificates libsdl2-dev && \
        # apt autoremove -y && \
        # apt install -y libasound2 && \
        rm snapclient_$snapcast_version-1_amd64.deb


CMD snapclient --config /etc/snapclient.conf