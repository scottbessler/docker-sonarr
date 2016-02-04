FROM alpine:edge

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk -U upgrade && \
  apk -U add \
    libmediainfo \
    ca-certificates \
    mono \
    && \
  apk del make gcc g++ && \
  rm -rf /tmp/src && \
  rm -rf /var/cache/apk/*

RUN wget http://download.sonarr.tv/v2/master/mono/NzbDrone.master.2.0.0.3732.mono.tar.gz -O NzbDrone.tgz && \
  tar xzvf NzbDrone.tgz && \
  rm NzbDrone.tgz

ADD start.sh /
RUN chmod +x /start.sh

EXPOSE 8989 9898 

CMD ["/start.sh"]
