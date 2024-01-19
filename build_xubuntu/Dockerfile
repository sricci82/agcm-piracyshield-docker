FROM docker.io/hectorm/xubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y software-properties-common && \
	apt-add-repository ppa:saxl/xrdp-egfx && \
	apt install -y -o Dpkg::Options::="--force-confdef" xrdp-egfx xorgxrdp-egfx && \
	apt install -y curl 
