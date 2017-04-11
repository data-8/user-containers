Docker images for UC Berkeley's DSEP
=======

This repository contains the dockerfiles for the singleuser images, hub, proxy, and culler.

Getting Started
-------

### Google Cloud Engine ###

Log into the gcloud console at [console.cloud.google.com](console.cloud.google.com/)

Click `Activate Google Cloud Shell` in the upper right-hand corner. It is an icon that looks like a small terminal.

In the new terminal window, clone this repository.

```
git clone https://github.com/data-8/docker-stacks
```

Edit the docker-settings.json file. Set the docker repo name corresponding to your cloud provider. Set the image types. You can leave this blank if you are only using the base image. Set the context prefix to whatever you want.

Here is an example:
```
{
    "clusters": ["dev", "prod"],
    "buildSettings": {
        "dockerRepo": "gcr.io/<your project>",
        "imageTypes": ["datahub", "prob140", "stat28"],
    },
    "gcloud": {
        "project": "<your project>",
        "zone": "<your zone>"
    }
}
```

Run the build script to generate Docker images.
```
./build.bash [ hub | proxy | base | user {user_type} ]
```

`hub` is for the jupyterhub image and `proxy` is for the jupyterhub proxy image. You will find their Dockerfiles in the respective subdirectories. The singleuser server builds utilize a shared base image specified by user/Dockerfile.base. Various other singleuser server images are built from this specified by user/Dockerfile.{user_type}. For example to build the singleuser image for the course Stat 28, you would run `./build.bash base` at least once, then `./build.bash user stat28`.

Each docker image is tagged with the git commit hash corresponding with the last git revision of the build files. 


File / Folder structure
-------

The subdirectories contain the Dockerfiles and scripts for the images used for
this deployment.

## Cal Blueprint

<a href="http://www.calblueprint.org/">
![bp](https://cloud.githubusercontent.com/assets/2468904/11998649/8a12f970-aa5d-11e5-8dab-7eef0766c793.png "BP Banner")
</a>

This project was worked on in close collaboration with
**[Cal Blueprint](http://www.calblueprint.org/)**.
Cal Blueprint is a student-run UC Berkeley organization devoted to matching
the skills of its members to our desire to see
social good enacted in our community. Each semester, teams of 4-5 students work
closely with a non-profit to bring technological solutions to the problems they
face every day.
