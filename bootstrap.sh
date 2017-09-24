#!/bin/bash
#

#
# create new post
# ./bootstrap.sh posts :title
#
posts() {
    cmd="hugo new -v posts/$(date +%Y/%m)/$1.md"

    echo $cmd
    $cmd
}

#
# start hugo dev server
#
server() {
    cmd="hugo server"

    echo $cmd
    $cmd
}

#
# render static file
#
build() {
    cmd="hugo -v"

    echo $cmd
    $cmd
}


#
# main
#
$1 $2

