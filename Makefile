APT_PROXY ?=
DOCKER ?= docker

all:

build:
	$(DOCKER) build --build-arg APT_PROXY="$(APT_PROXY)" -t ypcs/flask:latest .

run: build
	$(DOCKER) run -p 127.0.0.1:8080:8080 -d ypcs/flask:latest
