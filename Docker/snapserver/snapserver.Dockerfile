FROM debian:buster-slim

WORKDIR /data


LABEL maintainer "barrett.lowe@gmail.com"
ARG snapcast_version=0.25.0


RUN apt update && \
        apt upgrade -y && \
        apt install wget ca-certificates curl -y --no-install-recommends && \
        apt install -y libsdl2-dev && \
        wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_amd64.deb && \
        apt -f install -y ./snapserver_${snapcast_version}-1_amd64.deb
RUN apt install -y build-essential libasound2-dev cargo

RUN rustc --version
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

ENV PATH="/root/.cargo/bin:$PATH"
RUN rustup update && rustc --version

RUN cargo install librespot && \
        apt remove --purge -y wget ca-certificates libsdl2-dev cargo && \
        apt autoremove -y && \
        apt install -y libasound2 && rm snapserver_${snapcast_version}-1_amd64.deb


CMD snapserver --config /etc/snapserver.conf


