FROM debian:buster-slim



LABEL maintainer "barrett.lowe@gmail.com"



RUN apt update && \
        apt upgrade -y && \
        apt install wget ca-certificates -y --no-install-recommends && \
        apt install -y libsdl2-dev && \
        wget https://github.com/badaix/snapcast/releases/download/v0.24.0/snapserver_0.24.0-1_amd64.deb && \
        apt -f install -y ./snapserver_0.24.0-1_amd64.deb && \
        apt install -y cargo && cargo install librespot && \
        apt remove --purge -y wget ca-certificates libsdl2-dev cargo && \
        apt autoremove -y && \
        apt install -y libasound2 && rm snapserver_0.24.0-1_amd64.deb



ENV PATH="/root/.cargo/bin:$PATH"



CMD snapserver --config /etc/snapserver.conf


