FROM debian:buster-slim


LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.25.0


RUN apt update && \
        apt upgrade -y && \
        apt install wget ca-certificates -y --no-install-recommends && \
        apt install -y libsdl2-dev && \
        wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_amd64.deb && \
        apt -f install -y ./snapserver_${snapcast_version}-1_amd64.deb
RUN apt install -y build-essential libasound2-dev cargo
RUN rustup update
RUN cargo install librespot && \
        apt remove --purge -y wget ca-certificates libsdl2-dev cargo && \
        apt autoremove -y && \
        apt install -y libasound2 && rm snapserver_${snapcast_version}-1_amd64.deb



ENV PATH="/root/.cargo/bin:$PATH"



CMD snapserver --config /etc/snapserver.conf


