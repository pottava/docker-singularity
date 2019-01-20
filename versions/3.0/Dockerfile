# Singularity v3.0
#
# docker run --rm pottava/singularity:3.0
# docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:3.0 sh
# docker run --rm --entrypoint cat pottava/singularity:3.0 /usr/local/etc/singularity/singularity.conf

FROM alpine:3.8 AS build-gosu
RUN apk --no-cache add curl
RUN curl --location --silent --show-error --out /gosu \
    https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64
RUN chmod +x /gosu

FROM alpine:3.8 AS build-app
ENV SINGULARITY_VERESION=v3.0.2
RUN apk --no-cache add --virtual build-deps build-base bash openssl go git \
      linux-headers openssl-dev util-linux-dev gawk \
    && : \
    && : Install go 1.11 \
    && export PATH=/go/bin:/usr/local/go/bin:$PATH \
    && export GOPATH=/go \
    && GOLANG_VERSION=1.11.4 \
    && GOLANG_SRC_URL="https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz" \
    && GOLANG_SRC_SHA256="4cfd42720a6b1e79a8024895fa6607b69972e8e32446df76d6ce79801bbadb15" \
    && export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
    && wget -q "${GOLANG_SRC_URL}" -O golang.tar.gz \
    && echo "${GOLANG_SRC_SHA256}  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && cd /usr/local/go/src \
    && ./make.bash \
    && mkdir -p /go/src \
    && chmod -R 777 /go \
    && : \
    && : Install singularity \
    && mkdir -p /go/src/github.com/sylabs \
    && cd /go/src/github.com/sylabs \
    && git clone --depth=1 -b ${SINGULARITY_VERESION} https://github.com/sylabs/singularity.git \
    && cd singularity \
    && ./mconfig \
    && cd builddir \
    && make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && make install \
    && cd / \
    && rm -rf /go /usr/local/go /golang.tar.gz /root/.cache \
    && apk del --purge -r build-deps

FROM alpine:3.8
RUN apk --no-cache add bash ca-certificates squashfs-tools libseccomp \
    && rm -rf /lib/apk/*
COPY --from=build-app /usr/local /usr/local
COPY --from=build-gosu /gosu /usr/local/bin/gosu
WORKDIR /work
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
