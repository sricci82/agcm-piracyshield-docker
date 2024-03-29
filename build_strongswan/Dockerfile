FROM debian:12
ENV VERSION="5.9.13"

RUN \
  # install packages
  DEV_PACKAGES="wget bzip2 make gcc libssl-dev" && \
  apt-get -y update && \
  apt-get -y install iproute2 iputils-ping nano $DEV_PACKAGES && \
  \
  # download and build strongSwan IKEv2 daemon
  mkdir /strongswan-build && \
  cd /strongswan-build && \
  wget https://download.strongswan.org/strongswan-$VERSION.tar.bz2 && \
  tar xfj strongswan-$VERSION.tar.bz2 && \
  cd strongswan-$VERSION && \
  ./configure --prefix=/usr --sysconfdir=/etc --disable-defaults      \
    --enable-charon --enable-ikev2 --enable-nonce --enable-random     \
    --enable-openssl --enable-pem --enable-x509 --enable-pubkey       \
    --enable-constraints --enable-pki --enable-socket-default         \
    --enable-kernel-netlink --enable-swanctl --enable-resolve         \
    --enable-eap-identity --enable-eap-md5 --enable-eap-dynamic       \
    --enable-eap-tls --enable-updown --enable-vici                    \
    --enable-silent-rules  && \
   make all && make install && \
   cd / && rm -R strongswan-build && \
   ln -s /usr/libexec/ipsec/charon charon && \
   \
   # clean up
   apt-get -y remove $DEV_PACKAGES && \
   apt-get -y autoremove && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

COPY strongswan.conf /etc
COPY docker-entrypoint.sh /
