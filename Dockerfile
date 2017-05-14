FROM lsiobase/alpine:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package verions
ARG SYNC_VER="2.4.5"

# install packages and symlink libs
RUN \
 apk add --no-cache \
	curl \
	tar \
	libc6-compat && \
 mkdir -p \
	/lib64 && \
 ln /lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 && \

# install resilio
 curl -o \
 /tmp/sync.tar.gz -L \
	"https://download-cdn.getsync.com/${SYNC_VER}/linux-x64/resilio-sync_x64.tar.gz" && \
 tar xf \
 /tmp/sync.tar.gz \
	-C /usr/bin && \

# cleanup
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8888 55555
VOLUME /config /sync
