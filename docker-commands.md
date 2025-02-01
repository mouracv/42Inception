# Docker Commands

- `docker images` - Lists all images available in Docker.

- `docker ps` - Shows all containers currently running.
> `-a` shows all containers including stopped containers

- `docker pull {ImageName}:{tag/version}` - Pulls the image from the Docker hub.
> If no version is specified, it pulls the latest version.

- `docker run {Flags} {ImageName}:{tag/version}` - Creates a container from the specified image and starts it. If the image does not exist locally, it will pull from Docker hub.
> It will always create a new container; it never reuses a container created from the same image.\
> `--name {name}` sets the name for the container to be created.\
> `-d (--detach)` runs the container in the background and prints the container ID.\
> `-p {host_port}:{container_port} (--publish)` exposes the container's port to the host. by default, it uses the same port as the container.\
> `--network {Network_Name}` specifies which network the container will be part of. If not specified, it defaults to the bridge network.

- `docker logs {containerId/containerName}` - Displays the logs of a container running in the background.

- `docker stop {containerId/containerName}` - Stops the specified container.

- `docker start {containerId/containerName}` - Restarts one or more stopped containers.

- `docker build {DockerfilePath}` - Creates a Docker image from the Dockerfile.

- `docker exec -it {containerId/containerName} {Command}` - Accesses the container's terminal.
> `-it` enables interactive terminal mode.

To access a container outside of the Docker network, you need to set up port binding to expose the container outside of the Docker network.

# Docker Compose Commands

- `docker-compose up {Flags}` - Creates the containers and by default, creates a network for the services configured in the file.
> `--build` checks which containers need an image and builds them.

- `docker-compose down` - Removes all containers created by the docker-compose file.

- `docker-compose stop` - Stops all containers created by the docker-compose file.

- `docker-compose start` - Restarts all containers that were stopped by the docker-compose file.
