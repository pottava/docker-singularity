# Singularity v3.9
#
# docker run --rm pottava/singularity:3.9 help
# docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:3.9 bash
# docker run --rm --entrypoint cat pottava/singularity:3.9 /usr/local/etc/singularity/singularity.conf

FROM alpine:3.15.0 AS build-gosu
RUN apk --no-cache add curl
RUN curl --location --silent --show-error -o /gosu \
    https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64
RUN chmod +x /gosu

FROM golang:1.17.5-alpine3.15 AS build-app
ENV SINGULARITY_VERESION=3.9.2
RUN apk --no-cache add build-base linux-headers \
       openssl-dev util-linux-dev gawk git \
    && wget https://github.com/sylabs/singularity/releases/download/v${SINGULARITY_VERESION}/singularity-ce-${SINGULARITY_VERESION}.tar.gz \
    && tar -xzf singularity-ce-${SINGULARITY_VERESION}.tar.gz \
    && cd singularity-ce-${SINGULARITY_VERESION} \
    && ./mconfig \
    && cd builddir \
    && make "-j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)" \
    && make install \
    && rm -rf /usr/local/go /usr/local/etc/bash_completion.d

FROM alpine:3.15.0
RUN apk --no-cache add bash ca-certificates squashfs-tools libseccomp shadow tzdata \
    && rm -rf /usr/share/terminfo /lib/apk /etc/apk /etc/terminfo \
    && ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime
COPY --from=build-app /usr/local /usr/local
COPY --from=build-gosu /gosu /usr/local/bin/gosu
WORKDIR /work
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
