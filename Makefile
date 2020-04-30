
default:
	@echo "nothing"

# REPO_NAME = ubuntu-1604/fresh
# REPO_TAG  = init-tools

REPO_NAME = ubuntu/fresh
#REPO_TAG  = init-tools
REPO_TAG  = v2
IMAGE_NAME = $(REPO_NAME):$(REPO_TAG)

MOUNT_HOST= $(shell pwd)
MOUNT_GUEST= /home/fresh/shared/


WORK_DIR = /home/fresh/shared/


MY_IP=$(shell ifconfig en0 |grep inet\ | awk '{print $$2}')

run:
	@docker run --rm -it  \
		-p 55888:22 \
		-v $(MOUNT_HOST):$(MOUNT_GUEST) \
		-w $(WORK_DIR) \
		$(IMAGE_NAME) \
		/bin/bash

run-x11:
	@docker run --rm -it  \
		-e DISPLAY=$(MY_IP):0 \
		-p 55888:22 \
		-v $(MOUNT_HOST):$(MOUNT_GUEST) \
		-w $(WORK_DIR) \
		$(IMAGE_NAME) \
		/bin/bash

run-ssh:
	@docker run  -d  \
		--rm \
		-u root \
		-p 55888:22 \
		-v $(MOUNT_HOST):$(MOUNT_GUEST) \
		-w $(WORK_DIR) \
		$(IMAGE_NAME) \
		/usr/sbin/sshd -D

hilbert_dk:
	@docker run -it  \
		-p 55888:22 \
		-v $(MOUNT_HOST):$(MOUNT_GUEST) \
		-w $(WORK_DIR) \
		--name hilbert_dk \
		$(IMAGE_NAME) \
		/bin/bash

run-git:
	@docker run  --rm  \
		-v $(MOUNT_HOST):$(MOUNT_GUEST) \
		-w $(WORK_DIR) \
		$(IMAGE_NAME) \
		git branch

runX:
	docker run -it --rm -p 5901:5901 -e USER=root $(IMAGE_NAME) \
		    bash -c "mkdir ~/.vnc && vncserver :1 -geometry 1280x800 -depth 24 && tail -F ~/.vnc/*.log"

runXRoot:
	docker run -it --rm -p 5901:5901 -e USER=root $(IMAGE_NAME) \
		    bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"

clean_all_container:
	@docker ps -a &&  docker rm $(shell docker ps -aq);
	@docker images

clean_all_none_images:
	@docker rmi $(shell docker images| grep none| awk '{print $$3}')


clean_1:
	make clean_all_none_images

build:
	@docker build -t="$(IMAGE_NAME)" .

resize:
	cd ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux && \
	/Applications/Docker.app/Contents/MacOS/qemu-img convert -O qcow2 Docker.qcow2 Docker2.qcow2 && \
	mv Docker2.qcow2 Docker.qcow2
