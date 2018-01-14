# start hugo dev server with draft post
server:
	hugo server -D

# render static file
build:
	hugo -v

# create new post
new:
	hugo new -v posts/$$(date +%Y/%m)/$(POST).md
