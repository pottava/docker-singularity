# Singularity v2.4
#
# docker run --rm pottava/singularity:2.4 --version
# docker run --rm -it --privileged -v $(pwd):/work --entrypoint sh pottava/singularity:2.4
# docker run --rm -v $(pwd):/work pottava/singularity:2.4 \
#     pull --name hello-world.simg shub://vsoch/hello-world
# docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:2.4 \
#     shell hello-world.simg

FROM alpine:3.7

ENV SINGULARITY_VERESION=2.4.2

RUN apk --no-cache add bash python
RUN apk --no-cache add --virtual build-dependencies curl tar make gcc g++ linux-headers \
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

WORKDIR /work

ENTRYPOINT ["singularity"]
CMD ["--help"]
