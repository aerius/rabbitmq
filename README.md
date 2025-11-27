# rabbitmq

RabbitMQ container image as used by various other products.

## Versions

In this repository, the versions are maintained in [VERSION](./VERSION).
This version should reflect the version of the base rabbitmq image.
If it's the first version, it should be exactly that version.
If for whatever reason a change in our code is required, but the exact same base image is used, that version should get `-1` appended to it, or the next number in line if there already has been such a release.

As an example, when the base rabbitmq version in the [dockerfile](./docker/Dockerfile) is `3.4.6`, and the image used here is being tested, the version file should contain `3.4.6-SNAPSHOT`.
Once it is time to release, the version file should be updated to `3.4.6`, and a release/tag should be made with the same version (this will trigger a build and upload to our nexus environment).
After this, a commit should be made with `3.4.6-1-SNAPSHOT`, so the repository is save to commit changes to.
