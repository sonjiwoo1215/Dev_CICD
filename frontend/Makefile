ARCH = amd64
IMG_TAG = "Dockerhub"

all:
	cat ./Makefile

test:
	CI=true npm test

node:
	npm ci
	npm run build

image: Dockerfile node
	docker build --platform=linux/${ARCH} --tag ${IMG_TAG} .

push:
	docker push ${IMG_TAG}

deploy: notes-fe.yaml
	kubectl apply -f notes-fe.yaml

undeploy:
	kubectl delete -f notes-fe.yaml	

clean:
	/rm -rf build
	docker rmi ${IMG_TAG}