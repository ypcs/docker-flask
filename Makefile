APT_PROXY ?=
DOCKER ?= docker

all:

build:
	$(DOCKER) build --build-arg APT_PROXY="$(APT_PROXY)" -t ypcs/flask:latest .

run: build
	$(DOCKER) run -p 127.0.0.1:5000:5000 -d ypcs/flask:latest
