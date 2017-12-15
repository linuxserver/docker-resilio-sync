FROM lsiobase/xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# package verions
ARG SYNC_VER="stable"

RUN \
 echo "**** install resilio-sync ****" && \
 curl -o \
 /tmp/sync.tar.gz -L \
	"https://download-cdn.getsync.com/${SYNC_VER}/linux-x64/resilio-sync_x64.tar.gz" && \
 tar xf \
 /tmp/sync.tar.gz \
	-C /usr/bin && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8888 55555
VOLUME /config /sync
