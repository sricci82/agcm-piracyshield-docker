#!/bin/sh

cat <<EOF > /etc/swanctl/swanctl.conf
connections {

   agcom {
      # local_addrs  = ${IPSEC_LOCAL_TS}
      remote_addrs = ${IPSEC_REMOTE_PUBLIC_IP}

      local {
         auth = psk
         id = ${IPSEC_LOCAL_PUBLIC_IP}
      }
      remote {
         auth = psk
         id = ${IPSEC_REMOTE_PUBLIC_IP}
      }

      children {
         piracyshield {
            start_action = start
            local_ts  = ${IPSEC_LOCAL_TS}/32
            remote_ts = ${IPSEC_REMOTE_TS}/32

            # updown = /usr/local/libexec/ipsec/_updown iptables
            # rekey_packets = 1000000
            rekey_time = ${IPSEC_PHASE2_LIFETIME}
            rekey_bytes = ${IPSEC_PHASE2_LIFEBYTES}
            esp_proposals = ${IPSEC_PHASE2_PROPOSALS}
         }
      }

      version = 2
      mobike = no
      rekey_time = ${IPSEC_PHASE1_LIFETIME}
      proposals = ${IPSEC_PHASE1_PROPOSALS}
   }
}

secrets {
   ike-1 {
      id-bbox = ${IPSEC_LOCAL_PUBLIC_IP}
      id-agcm = ${IPSEC_REMOTE_PUBLIC_IP}
      secret = ${IPSEC_PSK}
   }
}
EOF

/sbin/ip address add ${IPSEC_LOCAL_TS}/32 dev lo
/charon
