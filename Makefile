VERSION=1.22.0

BUILDCOMMAND=docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7

build:
	@echo "Use target upload instead; --load does not work in current docker"
	@false
#	$(BUILDCOMMAND) --load --build-arg VERSION=$(VERSION) -t openmodelica/openmodelica:v$(VERSION)-minimal - < Dockerfile
#	$(BUILDCOMMAND) --load --build-arg BASE=openmodelica/openmodelica:v$(VERSION)-minimal -t openmodelica/openmodelica:v$(VERSION)-ompython - < Dockerfile.ompython
#	$(BUILDCOMMAND) --load --build-arg BASE=openmodelica/openmodelica:v$(VERSION)-ompython -t openmodelica/openmodelica:v$(VERSION)-gui - < Dockerfile.gui

bootstrap:
	docker pull tonistiigi/binfmt:latest
	docker run --privileged --rm tonistiigi/binfmt --uninstall qemu-*
	docker run --privileged --rm tonistiigi/binfmt --install all
	docker buildx use complex-builder || docker buildx create --name complex-builder --driver docker-container --bootstrap --use
	docker buildx ls

upload:
	$(BUILDCOMMAND) --build-arg VERSION=$(VERSION) -t openmodelica/openmodelica:v$(VERSION)-minimal --push - < Dockerfile
	$(BUILDCOMMAND) --build-arg BASE=openmodelica/openmodelica:v$(VERSION)-minimal -t openmodelica/openmodelica:v$(VERSION)-ompython --push - < Dockerfile.ompython
	$(BUILDCOMMAND) --build-arg BASE=openmodelica/openmodelica:v$(VERSION)-ompython -t openmodelica/openmodelica:v$(VERSION)-gui --push - < Dockerfile.gui
