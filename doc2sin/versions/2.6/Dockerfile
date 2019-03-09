# docker2singularity v2.6
#
# docker run --rm pottava/singularity:2.6-d2s
# docker run --rm --privileged \
#   -v /var/run/docker.sock:/var/run/docker.sock \
#   -v $(pwd):/output pottava/singularity:2.6-d2s \
#   --name tensorflow-1.13.simg \
#   nvcr.io/nvidia/tensorflow:19.02-py3

FROM docker:18.09.3

ENV SINGULARITY_VERESION=2.6.0 \
    D2S_VERION=v2.6

RUN apk --no-cache add "bash=4.4.19-r1" "tar=1.32-r0" "python2=2.7.15-r3" \
       "squashfs-tools=4.3-r5" "curl=7.64.0-r1"
RUN apk --no-cache add --virtual build-deps "make=4.2.1-r2" "gcc=8.2.0-r2" "g++=8.2.0-r2" \
       "linux-headers=4.18.13-r1" "libarchive-dev=3.3.2-r4" "file=5.35-r0" \
    && repo=https://github.com/sylabs/singularity/releases/download \
    && curl --location --silent --show-error --out singularity.tar.gz \
       "${repo}/${SINGULARITY_VERESION}/singularity-${SINGULARITY_VERESION}.tar.gz" \
    && tar xvf singularity.tar.gz \
    && cd "singularity-${SINGULARITY_VERESION}" \
    && ./configure --prefix=/usr/local \
    && make "-j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)" \
    && make install \
    && cd / \
    && rm -rf singularity* \
    && apk del --purge -r build-deps

RUN apk --no-cache add "e2fsprogs=1.44.5-r0" "rsync=3.1.3-r1"
RUN mkdir -p /usr/local/var/singularity/mnt
RUN repo=https://raw.githubusercontent.com/singularityware/docker2singularity \
    && curl --location --silent --show-error --out /docker2singularity.sh \
       "${repo}/${D2S_VERION}/docker2singularity.sh" \
    && chmod a+x docker2singularity.sh

ENTRYPOINT ["docker-entrypoint.sh", "/docker2singularity.sh"]
