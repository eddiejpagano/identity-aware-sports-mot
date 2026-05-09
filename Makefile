IMAGE_NAME = identity-aware-sports-mot

.PHONY: help build run test clean

help:
	@echo Available targets:
	@echo   make build  - Build the Docker image
	@echo   make run    - Run the Docker container
	@echo   make test   - Build and run the Docker container
	@echo   make clean  - Remove the Docker image

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run --rm $(IMAGE_NAME)

test: build run

clean:
	docker image rm -f $(IMAGE_NAME)