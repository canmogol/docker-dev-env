# docker-dev-env
Docker image for a basic development environment


#### How to install

* Docker image is available at hub.docker.com

`docker pull canmogol/devenv`

#### How to run

* Remove if already an instance running

`docker container stop devenv && docker container rm devenv`

* Run an instance 

`docker container run --name devenv -d -P canmogol/devenv`

* Find the ssh port

`docker port devenv 22`

* Login 

`ssh can@0.0.0.0 -p 32772`
