# docker2singularity
#
# docker run --rm pottava/singularity:2.5-d2s
# docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock \
#   -v $(pwd):/output pottava/singularity:2.5-d2s pottava/tensorflow:1.8

FROM docker:18.05.0-ce

ENV SINGULARITY_VERESION=2.5.2 \
    D2S_VERION=07452102bb626915a7c31a02f68cc4f4d4a9e5af

RUN apk --no-cache add bash tar python squashfs-tools
RUN apk --no-cache add --virtual build-dependencies curl make gcc g++ \
       linux-headers libarchive-dev file \
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

RUN apk --no-cache add e2fsprogs rsync
RUN mkdir -p /usr/local/var/singularity/mnt
RUN apk --no-cache add --virtual build-deps curl \
    && repo=https://raw.githubusercontent.com/singularityware/docker2singularity \
    && curl --location --silent --show-error --out /docker2singularity.sh \
       "${repo}/${D2S_VERION}/docker2singularity.sh" \
    && chmod a+x docker2singularity.sh \
    && apk del --purge -r build-deps

ENTRYPOINT ["docker-entrypoint.sh", "/docker2singularity.sh"]
