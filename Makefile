# Docker BIND Image
#
# Winston Astrachan 2019
#
help:
	@echo ""
	@echo "Usage: make COMMAND"
	@echo ""
	@echo "Docker BIND image makefile"
	@echo ""
	@echo "Commands:"
	@echo "  build        Build and tag image"
	@echo "  run          Start container in the background with locally mounted volume"
	@echo "  stop         Stop and remove container running in the background"
	@echo "  clean        Mark image for rebuild"
	@echo "  delete       Delete image and mark for rebuild"
	@echo ""

build: .bind.img

.bind.img:
	docker build -t wastrachan/bind:latest .
	@touch $@

.PHONY: run
run: build
	docker run -v "$(CURDIR)/config:/config" \
	           --name bind \
	           -p 53:53/udp \
	           -e PUID=1111 \
	           -e PGID=1112 \
	           --restart unless-stopped \
	           -d \
	           wastrachan/bind:latest

.PHONY: stop
stop:
	docker stop bind
	docker rm bind

.PHONY: clean
clean:
	rm -f .bind.img

.PHONY: delete
delete: clean
	docker rmi -f wastrachan/bind
