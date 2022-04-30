# FROM debian:buster-slim
FROM alpine:edge

WORKDIR /data


LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.25.0


# RUN apt update && \
#         apt upgrade -y && \
#         apt install wget ca-certificates curl -y --no-install-recommends && \
#         apt install -y libsdl2-dev && \
#         wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_amd64.deb && \
#         apt -f install -y ./snapserver_${snapcast_version}-1_amd64.deb
# RUN apt install -y build-essential libasound2-dev cargo

# ENV PATH="/root/.cargo/bin:$PATH"

RUN apk -U add curl cargo portaudio-dev protobuf-dev \
 && cd /root \
 && curl -LO https://github.com/plietar/librespot/archive/master.zip \
 && unzip master.zip \
 && cd librespot-master \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features \
 && mv target/release/librespot /usr/local/bin \
 && mkfifo /data/fifo \
 && cd / \
 && apk --purge del curl cargo portaudio-dev protobuf-dev \
 && apk add llvm-libunwind \
 && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/master.zip /root/librespot-master /root/.cargo

# RUN cargo install librespot && \
#         apt remove --purge -y wget ca-certificates libsdl2-dev cargo && \
#         apt autoremove -y && \
#         apt install -y libasound2 && rm snapserver_${snapcast_version}-1_amd64.deb


# CMD snapserver --config /etc/snapserver.conf


