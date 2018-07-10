# docker-dev-env
Docker image for a basic development environment


#### How to install

* Docker image is available at hub.docker.com

`docker pull canmogol/devenv`

#### How to run

* Remove if already an instance running

`docker container stop devenv && docker container rm devenv`

* Run an instance 

`docker container run --name devenv --hostname "devenv" -d -P canmogol/devenv`

* Find the ssh port

`docker port devenv 22`

this command should reveal the IP:PORT which you can connect using ssh. ex: 0.0.0.0:32774

* Login 

You may login to the 'devenv' container using its IP and PORT, also username and password both are 'can'
`ssh can@0.0.0.0 -p 32772`
