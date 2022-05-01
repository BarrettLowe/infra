FROM debian:buster-slim

LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.25.0

RUN apt update && \
        apt upgrade -y && \
        apt install wget -y && \
        wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapclient_${snapcast_version}-1_armhf.deb && \
        apt -f install -y ./snapclient_${snapcast_version}-1_armhf.deb && \
        rm snapclient_${snapcast_version}-1_armhf.deb


CMD snapclient -h $SNAPClient_host -s $snapclient_card -i $snapclient_instance