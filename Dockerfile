FROM lsiobase/alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

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
	https://download-cdn.resilio.com/2.4.1/linux-x64/resilio-sync_x64.tar.gz && \
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
