FROM wordpress:latest

ENV DEBIAN_FRONTEND noninteractive

COPY get_local_ip.sh /usr/local/bin/get_local_ip.sh
RUN chmod +x /usr/local/bin/get_local_ip.sh
