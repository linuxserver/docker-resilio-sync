[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/resilio-sync
[![](https://images.microbadger.com/badges/version/linuxserver/resilio-sync.svg)](https://microbadger.com/images/linuxserver/resilio-sync "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/resilio-sync.svg)](https://microbadger.com/images/linuxserver/resilio-sync "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/resilio-sync.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/resilio-sync.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-resilio-sync)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-resilio-sync/)
[hub]: https://hub.docker.com/r/linuxserver/resilio-sync/

[Resilio Sync][syncurl] (formerly BitTorrent Sync) uses the BitTorrent protocol to sync files and folders between all of your devices. There are both free and paid versions, this container supports both.
There is an official sync image but we created this one as it supports user mapping to simplify permissions for volumes.

[![syncthing](https://www.resilio.com/img/individual/freeproduct.jpg)][syncurl]
[syncurl]: https://www.resilio.com/individuals/


## Usage

```
docker run -d \
  --name=resilio-sync \
  -v <path to config>:/config \
  -v <path to data>:/sync \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8888:8888 \
  -p 55555:55555 \
  linuxserver/resilio-sync
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container. So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 `http://192.168.x.x:8080` would show you what's running INSIDE the container on port 80.

* `-p 8888 -p 55555` - the port(s) required to access the app
* `-v /config` - contains the settings
* `-v /sync` - sync folders root
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

This container is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it resilio-sync /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

* Webui is at `<your-ip>:8888`, for account creation and configuration.
* More info on setup at [Resilio Sync][syncurl]

## Info

* Shell access whilst the container is running: `docker exec -it resilio-sync /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f resilio-sync`

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' resilio-sync`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/resilio-sync`

## Versions

+ **08.02.17:** Rebase to alpine 3.5.
+ **02.11.16:** Initial Release.
