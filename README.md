[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/resilio-sync](https://github.com/linuxserver/docker-resilio-sync)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/resilio-sync.svg)](https://microbadger.com/images/linuxserver/resilio-sync "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/resilio-sync.svg)](https://microbadger.com/images/linuxserver/resilio-sync "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/resilio-sync.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/resilio-sync.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-resilio-sync/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-resilio-sync/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/resilio-sync/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/resilio-sync/latest/index.html)

[Resilio-sync](https://www.resilio.com/individuals/) (formerly BitTorrent Sync) uses the BitTorrent protocol to sync files and folders between all of your devices. There are both free and paid versions, this container supports both. There is an official sync image but we created this one as it supports user mapping to simplify permissions for volumes.

[![resilio-sync](https://www.resilio.com/img/individual/freeproduct.jpg)](https://www.resilio.com/individuals/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/resilio-sync` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=resilio-sync \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e UMASK_SET=<022> \
  -p 8888:8888 \
  -p 55555:55555 \
  -v <path to config>:/config \
  -v <path to downloads>:/downloads \
  -v <path to data>:/sync \
  --restart unless-stopped \
  linuxserver/resilio-sync
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  resilio-sync:
    image: linuxserver/resilio-sync
    container_name: resilio-sync
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - UMASK_SET=<022>
    volumes:
      - <path to config>:/config
      - <path to downloads>:/downloads
      - <path to data>:/sync
    ports:
      - 8888:8888
      - 55555:55555
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8888` | WebUI |
| `-p 55555` | Sync Port. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e UMASK_SET=<022>` | For umask setting of resilio-sync, default if left unset is 022. |
| `-v /config` | Where Jackett should store its config file. |
| `-v /downloads` | Folder for downloads/cache. |
| `-v /sync` | Sync folders root. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

* Webui is at `<your-ip>:8888`, for account creation and configuration.
* More info on setup at [Resilio Sync](https://www.resilio.com/individuals/)



## Support Info

* Shell access whilst the container is running: `docker exec -it resilio-sync /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f resilio-sync`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' resilio-sync`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/resilio-sync`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/resilio-sync`
* Stop the running container: `docker stop resilio-sync`
* Delete the container: `docker rm resilio-sync`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start resilio-sync`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot resilio-sync
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull resilio-sync`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d resilio-sync`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **11.02.19:** - Rebase to bionic, add pipeline logic and multi arch.
* **05.02.18:** - Add downloads volume mount.
* **28.01.18:** - Add /sync to dir whitelist.
* **26.01.18:** - Use variable for arch to bring in line with armhf arch repo.
* **15.12.17:** - Fix continuation lines.
* **02.06.17:** - Rebase to ubuntu xenial, alpine linux no longer works with resilio.
* **22.05.17:** - Add variable for user defined umask.
* **14.05.17:** - Use fixed version instead of latest, while 2.5.0 is broken on non glibc (alpine).
* **08.02.17:** - Rebase to alpine 3.5.
* **02.11.16:** - Initial Release.
