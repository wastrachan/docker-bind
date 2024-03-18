# BIND9 Docker Image

BIND9 in a Docker container, with configuration and zone files in a volume, and a configurable UID/GID for the BIND process.

[![](https://circleci.com/gh/wastrachan/docker-bind.svg?style=svg)](https://circleci.com/gh/wastrachan/docker-bind)
[![](https://img.shields.io/docker/pulls/wastrachan/bind.svg)](https://hub.docker.com/r/wastrachan/bind)

## Install

#### Docker Hub

Pull the latest image from Docker Hub:

```shell
docker pull wastrachan/bind
```

#### Github Container Registry

Or, pull from the GitHub Container Registry:

```shell
docker pull ghcr.io/wastrachan/bind
```

#### Build From Source

Clone this repository, and run `make build` to build an image:

```shell
git clone https://github.com/wastrachan/docker-bind.git
cd docker-bind
make build
```

## Run

#### Docker

Run this image with the `make run` shortcut, or manually with `docker run`.

```shell
docker run -v "$(pwd)/config:/config" \
           --name bind \
           --rm \
           -p 53:53/udp \
           -e PUID=$(id -u) \
           -e PGID=$(id -g) \
           wastrachan/bind:latest
```

## Configuration

Configuration files are stored in the `/config` volume. You may wish to mount this volume as a local directory, as shown in the examples above. `/config/named.conf` is the main configuration file for the application. Review the BIND man pages if you are unfamiliar with how to configure BIND.

#### User / Group Identifiers

If you'd like to override the UID and GID of the `named` process, you can do so with the environment variables `PUID` and `PGID`. This is helpful if other containers must access your configuration volume.

#### Services

| Service | Port |
| ------- | ---- |
| DNS     | 53   |

#### Volumes

| Volume    | Description                                             |
| --------- | ------------------------------------------------------- |
| `/config` | Configuration directory for BIND config and zone files. |

## License

The content of this project itself is licensed under the [MIT License](LICENSE).

View [license information](https://www.isc.org/licenses/) for the software contained in this image.
