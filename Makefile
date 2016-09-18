default:
	@echo "nothing"

run:
	@docker run -it --rm -v ~/Docker/shared:/home/fresh/shared\
		-w /home/fresh/shared/Aegis_FW \
		ubuntu/fresh:init /bin/bash

runX:
	docker run -it --rm -p 5901:5901 -e USER=root ubuntu/fresh:init \
		    bash -c "mkdir ~/.vnc && vncserver :1 -geometry 1280x800 -depth 24 && tail -F ~/.vnc/*.log"

runXRoot:
	docker run -it --rm -p 5901:5901 -e USER=root ubuntu/fresh:init \
		    bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"

clean_all:
	@docker ps -a &&  docker rm $(shell docker ps -aq);
	@docker images

build:
	@docker build -t="ubuntu/fresh:init" .

resize:
	cd ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux && \
	/Applications/Docker.app/Contents/MacOS/qemu-img convert -O qcow2 Docker.qcow2 Docker2.qcow2 && \
	mv Docker2.qcow2 Docker.qcow2
