# BitTorrent Sync
#
# VERSION               0.1

FROM ubuntu:15.04
#MAINTAINER Bertrand Chazot <bertrand@bittorrent.com>
LABEL com.getsync.version="1.3.109"

ADD http://syncapp.bittorrent.com/1.3.109/btsync_x64-1.3.109.tar.gz /tmp/sync.tgz
RUN tar -xf /tmp/sync.tgz -C /usr/sbin btsync && rm -f /tmp/sync.tgz

COPY btsync.conf /etc/
COPY run_sync /opt/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

RUN groupadd -r btsync && useradd -r -g btsync btsync
USER btsync

ENTRYPOINT ["/opt/run_sync"]
CMD ["--log", "--config", "/etc/btsync.conf"]
