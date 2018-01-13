# Singularity

http://singularity.lbl.gov/

## Supported tags and respective `Dockerfile` links:

・latest ([versions/2.4/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.4/Dockerfile))  
・2.4 ([versions/2.4/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.4/Dockerfile))  

## Usage

```
$ docker run --rm -it --privileged -v $(pwd):/work --entrypoint sh \
    pottava/singularity:2.4
```

```
$ docker run --rm -v $(pwd):/work pottava/singularity:2.4 \
    pull --name hello-world.simg shub://vsoch/hello-world
$ docker run --rm -it --privileged -v $(pwd):/work \
    pottava/singularity:2.4 shell hello-world.simg
```
