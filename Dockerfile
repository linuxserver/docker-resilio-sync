FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SYNC_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

RUN \
 echo "**** install resilio-sync ****" && \
 if [ -z ${SYNC_VERSION+x} ]; then \
	SYNC_VERSION=$(curl -sL https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux | awk -F '(download-cdn.resilio.com/|/Debian/)' '/x64/ {print $2}'); \
 fi && \
 curl -o \
 /tmp/sync.deb -L \
	"https://download-cdn.resilio.com/${SYNC_VERSION}/Debian/resilio-sync_${SYNC_VERSION}-1_amd64.deb" && \
 dpkg -i \
 /tmp/sync.deb && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8888 55555
VOLUME /config /sync
