# Singularity v2.3
#
# docker run --rm pottava/singularity:2.3
# docker run --rm --entrypoint cat pottava/singularity:2.3 /usr/local/etc/singularity/singularity.conf

FROM alpine:3.7

ENV SINGULARITY_VERESION=2.3.2

RUN apk --no-cache add bash tar python squashfs-tools e2fsprogs
RUN apk --no-cache add --virtual build-dependencies curl make gcc g++ linux-headers \
    && repo=https://github.com/singularityware/singularity/releases/download \
    && curl --location --silent --show-error --out singularity.tar.gz \
       ${repo}/${SINGULARITY_VERESION}/singularity-${SINGULARITY_VERESION}.tar.gz \
    && tar xvf singularity.tar.gz \
    && cd singularity-${SINGULARITY_VERESION} \
    && ./configure --prefix=/usr/local \
    && make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && make install \
    && cd / \
    && rm -rf singularity* \
    && apk del --purge -r build-dependencies

RUN apk --no-cache add --virtual build-dependencies curl openssl \
    && curl --location --silent --show-error --out /usr/local/bin/gosu \
       https://github.com/tianon/gosu/releases/download/1.8/gosu-amd64 \
    && chmod 755 /usr/local/bin/gosu \
    && apk del --purge -r build-dependencies

WORKDIR /work

ADD entrypoint.sh /sbin/
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
