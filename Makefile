# start hugo dev server with draft post
server:
	hugo server -D

# render static file
build:
	hugo -v

# create new post
new-post:
ifdef POST
	hugo new -v posts/$$(date +%Y/%m)/$(POST).md
endif
ifndef POST
	@echo empty post title
endif

