# Singularity v3.2
#
# docker run --rm pottava/singularity:3.2 help
# docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:3.2 bash
# docker run --rm --entrypoint cat pottava/singularity:3.2 /usr/local/etc/singularity/singularity.conf

FROM alpine:3.9.4 AS build-gosu
RUN apk --no-cache add "curl=7.64.0-r2"
RUN curl --location --silent --show-error --out /gosu \
    https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64
RUN chmod +x /gosu

FROM golang:1.12.5-alpine3.9 AS build-app
ENV SINGULARITY_VERESION=v3.2.1
RUN apk --no-cache add "build-base=0.5-r1" "linux-headers=4.18.13-r1" \
       "openssl-dev=1.1.1b-r1" "util-linux-dev=2.33-r0" "gawk=4.2.1-r0" \
       "git=2.20.1-r0" \
    && mkdir -p /go/src/github.com/sylabs \
    && cd /go/src/github.com/sylabs \
    && git clone --depth=1 -b "${SINGULARITY_VERESION}" https://github.com/sylabs/singularity.git \
    && cd singularity \
    && ./mconfig \
    && cd builddir \
    && make "-j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)" \
    && make install \
    && rm -rf /usr/local/go /usr/local/etc/bash_completion.d

FROM alpine:3.9.4
RUN apk --no-cache add "bash=4.4.19-r1" "ca-certificates=20190108-r0" \
       "squashfs-tools=4.3-r5" "libseccomp=2.3.3-r1" \
    && rm -rf /usr/share/terminfo /lib/apk /etc/apk /etc/terminfo
COPY --from=build-app /usr/local /usr/local
COPY --from=build-gosu /gosu /usr/local/bin/gosu
WORKDIR /work
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
