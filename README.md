# nginx-lb

This is a simple NGINX load balancer that automatically reconfigures itself according to running containers.


## How it works

0. `nginx-lb` search for running containers and group them by application name*
0. Configures an NGINX virtual host for every app load balancing between its Docker instances.
0. Monitors Docker for events
0. Repeat setup when an event is found

* An application name is detected by splitting containers name with _ and discarting the last bit. Examples of container names: `myapp_1` `myapp_2` `mywebapp_web_1`. For those examples the app name would be `myapp`, `myapp` and `mywebapp_web`, respectively. Note that `myapp` has two instances to be load balanced to.


## Install

`nginx-lb` is an [automated Docker image](https://registry.hub.docker.com/u/rochacon/nginx-lb). Pull it with:

    docker pull rochacon/nginx-lb


## Configuration

- `DOCKER_HOST` - HTTP address of the Docker host. e.g `http://172.42.17.1:2375`
- `PORTS` - Comma separated list of containers ports to monitor. e.g 80,8080


## Usage

Launch `nginx-lb`


    docker run -d -p 80:80 --name nginx-lb \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        -e PORTS=80,8080 \
        rochacon/nginx-lb


Use the `DOCKER_HOST` environment to monitor a Docker daemon listening on TCP.


Launch some app instances


	docker run -p 80 --name myapp.example.com_1 myimage
	docker run -p 80 --name myapp.example.com_2 myimage
	docker run -p 80 --name myapp.example.com_3 myimage


Hit application

	
	curl myapp.example.com


## Checking current setup

    docker exec nginx-lb cat /etc/nginx/nginx.conf


## License

MIT
