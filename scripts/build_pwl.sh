#!/bin/bash

# build_pwl.sh
#
# This is the template for a script added to sources to
# compile the respective package. It would be added by
# the patching process.

# Note this is a rough script. Still needs sanity checks!
# The sample entries are kept (but commented) from boa

# Change to src directory
#cd src

# Configure and compile
#./configure
#make

# Return to source base dir
#cd ../

# Cleanup install filesystem
#rm -rf ../../mnt/*

# Create install directories
#mkdir -p ../../mnt/etc/boa
#mkdir -p ../../mnt/bin
#mkdir -p ../../mnt/home/htdocs
#mkdir -p ../../mnt/home/cgi-bin
#mkdir -p ../../mnt/var/log/boa
#mkdir -p ../../mnt/var/spool/boa
#mkdir -p ../../mnt/lib/boa

# Copy binaries
#objcopy --strip-all src/boa ../../mnt/bin/boa
#objcopy --strip-all src/boa_indexer ../../mnt/lib/boa/boa_indexer

# Set permissions
#chmod 755 ../../mnt/bin/boa 
#chmod 755 ../../mnt/lib/boa/boa_indexer

# Copy configuration files
#cp boa.conf ../../mnt/etc/boa/boa.conf

# Create package
#cd ../../mnt
#tar cvpf ../packages/network_servers/boa-0.94.0.tar *

# Clean up after ourselves
#rm -rf *

# Return and exit...
#cd -

exit 0


