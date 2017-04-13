Docker images for UC Berkeley's DSEP
=======

This repository contains the dockerfiles for singleuser images.

Getting Started
-------

Clone this repository.

```
git clone https://github.com/data-8/user-containers
```

Run the build script to generate Docker images.
```
./build.bash [ -r REGISTRY ] [ base | {user_type} ]
```

The `-r` option can be a docker container registry, e.g. gcr.io/YOUR_ORG. The
singleuser server builds utilize a shared base image specified by
base/Dockerfile. Various other singleuser server images are built from this
specified by {user_type}/Dockerfile. For example to build the singleuser image
for the course Stat 28, you would run `./build.bash base` at least once, then
`./build.bash stat28`.

Each docker image is tagged with the git commit hash corresponding with the last git revision of the build files. 


File / Folder structure
-------

The subdirectories contain the Dockerfiles and scripts for the images used for
this deployment.
