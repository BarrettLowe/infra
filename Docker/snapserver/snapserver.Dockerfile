FROM debian:bullseye-slim as stage1

WORKDIR /data


LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.25.0


RUN apt update && \
        apt upgrade -y && \
        apt install wget ca-certificates curl -y --no-install-recommends && \
        apt install -y libsdl2-dev --no-install-recommends && \
        wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_amd64.deb && \
        apt -f install -y ./snapserver_${snapcast_version}-1_amd64.deb && \
        apt install -y build-essential libasound2-dev cargo unzip && \
        wget https://github.com/librespot-org/librespot/archive/refs/tags/v0.3.1.zip && \
        unzip v0.3.1.zip && \
        cd librespot-0.3.1 && \
        cargo build --release --no-default-features && \
        cp target/release/librespot /usr/bin/. && \
        cd .. && \
        rm -rf librespot-0.3.1 && \
        rm -f v0.3.1.zip && \
        apt remove --purge -y wget unzip ca-certificates libsdl2-dev cargo build-essential && \
        apt autoremove -y && \
        rm snapserver_${snapcast_version}-1_amd64.deb

CMD snapserver --config /etc/snapserver.conf


