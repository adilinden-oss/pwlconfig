#!/bin/bash

# Generate .list from .tar files

PKG_PATH="../packages"

for i in `du -a ${PKG_PATH} | grep .tar | cut -f2-`
do
    echo "Processing.... $i"
    tar tf $i > `expr $i : '\(.*\).tar$'`".list"
done

exit 0
