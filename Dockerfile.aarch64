FROM lsiobase/ubuntu:arm64v8-bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SYNC_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install resilio-sync ****" && \
 if [ -z ${SYNC_VERSION+x} ]; then \
	SYNC_VERSION=$(curl -sX GET "https://download-cdn.getsync.com/stable/version.txt"); \
 fi && \
 curl -o \
 /tmp/sync.deb -L \
	"https://download-cdn.resilio.com/${SYNC_VERSION}/Debian/resilio-sync_${SYNC_VERSION}-1_arm64.deb" && \
 dpkg -i \
 /tmp/sync.deb && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8888 55555
VOLUME /config /downloads /sync
