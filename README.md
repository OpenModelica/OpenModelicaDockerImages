# Creating OpenModelica docker images

Dockerfiles for the OpenModelica version correspond to the branch name.

## Dependencies

You need to have a multi-platform build setup: https://docs.docker.com/build/building/multi-platform/

```
make bootstrap
```

## Building

To create the docker images, run:

```
make build # Will fail until docker supports multi-arch containers better
make upload
```

