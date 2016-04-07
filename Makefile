#
# This is a generic Makefile. It use to build Docker images.
#

all: build

build:
	   @docker build -t imac-cloud/opensips:1.0.0 .

quickstart:
	@echo "Quick start sample"
	@echo "有空再改"
