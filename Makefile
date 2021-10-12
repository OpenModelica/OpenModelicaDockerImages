VERSION=1.18.0

build:
	docker build --build-arg VERSION=$(VERSION) -t openmodelica/openmodelica:v$(VERSION)-minimal - < Dockerfile
	docker build --build-arg BASE=openmodelica/openmodelica:v$(VERSION)-minimal -t openmodelica/openmodelica:v1.18.0-ompython - < Dockerfile.ompython
	docker build --build-arg BASE=openmodelica/openmodelica:v$(VERSION)-ompython -t openmodelica/openmodelica:v1.18.0-gui - < Dockerfile.gui

upload:
	docker push openmodelica/openmodelica:v$(VERSION)-minimal
	docker push openmodelica/openmodelica:v$(VERSION)-ompython
	docker push openmodelica/openmodelica:v$(VERSION)-gui
