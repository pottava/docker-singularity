# Singularity

http://singularity.lbl.gov/

## Supported tags and respective `Dockerfile` links:

・latest ([versions/2.4/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.4/Dockerfile))  
・2.4 ([versions/2.4/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.4/Dockerfile))  
・2.3 ([versions/2.3/Dockerfile](https://github.com/pottava/docker-singularity/blob/master/versions/2.3/Dockerfile))  

## Usage

### Test

```
$ docker run --rm pottava/singularity:2.4 --version
$ docker run --rm -it --privileged -v $(pwd):/work pottava/singularity:2.4 sh
```

### Configure

Install docker and create a following shell script:

```
$ sudo sh -c 'cat << EOF > /usr/local/bin/singularity
#!/bin/sh
docker run --rm -it --privileged -e UID=\$(id -u) -e GID=\$(id -g) \\
  -v \$(pwd):/home/singularity -v /tmp:/tmp -w /home/singularity \\
  pottava/singularity:2.4 "\$@"
EOF'
sudo chmod +x /usr/local/bin/singularity
```

### Run

```
$ singularity pull --name hello.simg shub://vsoch/hello-world
$ singularity run hello.simg
$ singularity exec hello.simg ls
$ singularity shell hello.simg
```
