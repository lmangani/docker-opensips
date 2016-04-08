#
# This is a generic Makefile. It use to build Docker images.
#

all: build

build:
	   @docker build -t imac-cloud/opensips:1.0.0 .

quickstart:
	@echo "Quick starting sample"
	@docker run --name opensips -d -p 5060:5060/udp \
	-e ADVERTISED_IP="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')" \
	imac-cloud/opensips:1.0.0
