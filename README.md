# Singularity

http://singularity.lbl.gov/

## Supported tags and respective `Dockerfile` links:

・latest ([versions/2.6/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.6/Dockerfile))  
・2.6 ([versions/2.6/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.6/Dockerfile))  
・2.5 ([versions/2.5/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.5/Dockerfile))  
・2.4 ([versions/2.4/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.4/Dockerfile))  
・2.3 ([versions/2.3/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.3/Dockerfile))  

## Usage

### Test

```
$ docker run --rm pottava/singularity:2.6 --version
$ docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:2.6 sh
```

### Configure

Install docker and create a following shell script:

```
$ sudo sh -c 'cat << EOF > /usr/local/bin/singularity
#!/bin/sh
docker run --rm -it --privileged -e UID=\$(id -u) -e GID=\$(id -g) \\
  -v /var/run/docker.sock:/var/run/docker.sock \\
  -v \$(pwd):/home/singularity -v /tmp:/tmp -w /home/singularity \\
  pottava/singularity:2.6 "\$@"
EOF'
$ sudo chmod +x /usr/local/bin/singularity
```

### Run

- v2.4 ~

```
$ singularity pull --name hello.simg shub://vsoch/hello-world
$ singularity run hello.simg
$ singularity exec hello.simg ls
$ singularity shell hello.simg
```

- ~ v2.3

```
$ docker run --rm -it --privileged -v $(pwd):/tmp \
    --entrypoint sh pottava/singularity:2.3 -c \
    "singularity create --size 100 alpine.simg && cp /work/alpine.simg /tmp/"
$ singularity import alpine.simg docker://alpine:3.7
$ singularity exec alpine.simg cat /etc/os-release
$ singularity shell alpine.simg
```
