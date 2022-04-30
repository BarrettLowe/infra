FROM debian:buster-slim


LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.25.0


RUN apt update && \
        apt upgrade -y && \
        apt install wget ca-certificates curl -y --no-install-recommends && \
        apt install -y libsdl2-dev && \
        wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_amd64.deb && \
        apt -f install -y ./snapserver_${snapcast_version}-1_amd64.deb
RUN apt install -y build-essential libasound2-dev cargo

ENV PATH="/root/.cargo/bin:$PATH"

RUN apt install unzip
RUN  cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/refs/tags/v0.3.1.zip \
 && unzip v0.3.1.zip \
 && cd librespot-master \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features \
 && mv target/release/librespot /usr/local/bin

# RUN cargo install librespot && \
#         apt remove --purge -y wget ca-certificates libsdl2-dev cargo && \
#         apt autoremove -y && \
#         apt install -y libasound2 && rm snapserver_${snapcast_version}-1_amd64.deb


CMD snapserver --config /etc/snapserver.conf


