FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN truncate -s0 /tmp/preseed.cfg; \
    echo "tzdata tzdata/Areas select Europe" >> /tmp/preseed.cfg; \
    echo "tzdata tzdata/Zones/Europe select Berlin" >> /tmp/preseed.cfg; \
    debconf-set-selections /tmp/preseed.cfg && \
    rm -f /etc/timezone /etc/localtime && \
    apt-get update -y && \
    apt-get install -y nginx vim curl jq wget gnupg && \

    apt-get clean

COPY ./db.sh /
COPY ./frontend.sh /

RUN chmod 770 db.sh && \
    chmod 700 frontend.sh && \
    ./db.sh && \
    ./frontend.sh

EXPOSE 80 8080 27017

CMD ["nginx", "-g", "daemon off;"]
