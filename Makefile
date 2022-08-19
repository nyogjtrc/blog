# start hugo dev server with draft post
.PHONY: server
server:
	hugo server -D

# render static file
.PHONY: build
build:
	hugo -v

# create new post
.PHONY: new-post
new-post:
ifdef POST
	hugo new -v posts/$$(date +%Y/%m)/$$(echo $(POST) | sed 's/ /-/g').md
endif
ifndef POST
	@echo empty post title
endif

