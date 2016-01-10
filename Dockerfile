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

RUN wget http://download.sonarr.tv/v2/master/mono/NzbDrone.master.2.0.0.3645.mono.tar.gz -O NzbDrone.tgz && \
  tar xzvf NzbDrone.tgz && \
  rm NzbDrone.tgz

ADD start.sh /
RUN chmod +x /start.sh

EXPOSE 8989 9898 

CMD ["/start.sh"]


# ADD ./start.sh /start.sh
# RUN chmod u+x  /start.sh

# EXPOSE 5050

# CMD ["/start.sh"]

# # ENV DEBIAN_FRONTEND="noninteractive" \
# #     LANG="en_US.UTF-8" \
# #     LC_ALL="C.UTF-8" \
# #     LANGUAGE="en_US.UTF-8"

# # mono 3.10 currently doesn't install in debian jessie due to libpeg8 being removed.

# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
#   && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
#   && echo "deb-src http://httpredir.debian.org/debian wheezy main contrib non-free" | tee -a /etc/apt/sources.list.d/deb-src.list \
#   && echo "deb http://apt.sonarr.tv/ develop main" | tee -a /etc/apt/sources.list.d/sonarr.list \
#   && echo "deb http://ppa.launchpad.net/jcfp/ppa/ubuntu precise main" | tee -a /etc/apt/sources.list.d/sabnzbdplus.list \
#   && apt-key adv --keyserver hkp://pool.sks-keyservers.net:11371 --recv-keys 0x98703123E0F52B2BE16D586EF13930B14BB9F05F \
#   && apt-get update -q \
#   && apt-get install -qy nzbdrone mediainfo curl python-software-properties software-properties-common supervisor ca-certificates procps \
#   sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush \
#   par2 python-yenc unzip git-core \
#   && apt-get build-dep unrar-nonfree \
#   && apt-get source -b unrar-nonfree \
#   && dpkg -i unrar*.deb \
#   && apt-get clean \
#   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# #git clone https://github.com/RuudBurger/CouchPotatoServer.git

# # RUN chown -R nobody:users /opt/NzbDrone \
# #   ; mkdir -p /volumes/config/sonarr /volumes/completed /volumes/media \
# #   && chown -R nobody:users /volumes

# # sabnzbd
# EXPOSE 8091 9090

# # sonarr
# # VOLUME /volumes/config
# # VOLUME /volumes/completed
# # VOLUME /volumes/media

# ADD start.sh /
# RUN chmod +x /start.sh

# ADD supervisord.conf /
# RUN mkdir /logs /config
# # ADD sonarr-update.sh /sonarr-update.sh
# # RUN chmod 755 /sonarr-update.sh \
# #   && chown nobody:users /sonarr-update.sh

# # USER nobody
# # WORKDIR /opt/NzbDrone

# # ENTRYPOINT ["/start.sh"]

# # CMD ["/usr/bin/sabnzbdplus","--config-file","/config","--server","0.0.0.0:8080","--console"]

# CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf", "-n"]