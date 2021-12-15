# Singularity

http://singularity.lbl.gov/

[![pottava/singularity](http://dockeri.co/image/pottava/singularity)](https://hub.docker.com/r/pottava/singularity/)

## Supported tags and respective `Dockerfile` links:

・latest ([versions/3.9/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/3.9/Dockerfile))  
・3.9 ([versions/3.9/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/3.9/Dockerfile))  
・2.6 ([versions/2.6/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.6/Dockerfile))  

## Usage

### Test

```
$ docker run --rm pottava/singularity:3.9 --version
$ docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:3.9 bash
```

### Configure

Install docker and create a following shell script:

```
$ sudo sh -c 'cat << EOF > /usr/local/bin/singularity
#!/bin/sh
docker run --rm -it --privileged -e UID=\$(id -u) -e GID=\$(id -g) \\
  -v /var/run/docker.sock:/var/run/docker.sock \\
  -v /etc/localtime:/etc/localtime:ro \\
  -v \$(pwd):/home/singularity -v /tmp:/tmp -w /home/singularity \\
  pottava/singularity:3.9 "\$@"
EOF'
$ sudo chmod +x /usr/local/bin/singularity
```

### Run

- v3.0 <= x

```
$ singularity pull --name hello.simg shub://vsoch/hello-world
$ sudo singularity run hello.simg
$ sudo singularity exec hello.simg ls
$ sudo singularity shell hello.simg
```

- v2.4 <= x < v3.0

```
$ singularity pull --name hello.simg shub://vsoch/hello-world
$ singularity run hello.simg
$ singularity exec hello.simg ls
$ singularity shell hello.simg
```

- < v2.3

```
$ docker run --rm -it --privileged -v $(pwd):/tmp \
    --entrypoint sh pottava/singularity:2.3 -c \
    "singularity create --size 100 alpine.simg && cp /work/alpine.simg /tmp/"
$ singularity import alpine.simg docker://alpine:3.7
$ singularity exec alpine.simg cat /etc/os-release
$ singularity shell alpine.simg
```
