ARCH = amd64
IMG_TAG = "Dockerhub"

all:
	cat ./Makefile

test:
	npm test

node:
	npm ci
	npm run build

image: Dockerfile
	docker build --platform linux/$(ARCH) --tag $(IMG_TAG) .