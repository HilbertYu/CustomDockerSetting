default:
	@echo "nothing"

att:
	@docker exec -ti gloomy_jang

run:
	@docker run -it -v ~/Docker/shared:/home/fresh/shared\
		ubuntu/fresh:init /bin/bash

clean_all:
	@docker ps -a &&  docker rm $(shell docker ps -aq);
	@docker images

build:
	@docker build -t="ubuntu/fresh:init" .

resize:
	cd ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux && \
	/Applications/Docker.app/Contents/MacOS/qemu-img convert -O qcow2 Docker.qcow2 Docker2.qcow2 && \
	mv Docker2.qcow2 Docker.qcow2
