#!/bin/bash

# build_pwl.sh
#
PACKAGE=ncftp-3.0beta21
CATEGORY="../packages/network_clients"
#
# Note: The above path is as seen from the ../../mnt directory!
#
# This is the template for a script added to sources to
# compile the respective package. It would be added by
# the patching process.
#
##################################################################
#
# How to create PWL patches
# -------------------------
#
# 1. Download the package source into ./sources/
# 2. Extract the package source into ./build_pwl/
# 3. Keep an original set of the sources by doing
#    'cp -a <sources> <sources>-original'
# 4. cd into <sources> and make any necessary changes, create
#    the build_pwl.sh similar to this one
# 5. 'cd ..' into the ./build_pwl/ directory and create the
#    patchfile by doing 'diff -Naur <sources>-original <sources>'
# 6. cd into the <sources> and run build_pwl.sh, test the package
# 7. If changes are necessary delete the sources, copy the
#    sources, apply the patch and keep modifying...
# 8. Good Luck!
#
##################################################################
#
# How to create packages from patches
# ----------------------------------- 
#
# 1. Extract the sources from ./sources/ into ./build_pwl/
# 2. Apply the patch by doing 'patch -p0 < patchfile' in the
#    build_pwl directory
# 3. 'chmod 755 sources/build_pwl.sh'
# 4. Run build_pwl.sh
# 5. The package has been build
#
##################################################################
#
# How to create a patch for a package without sources
# ---------------------------------------------------
#
# >>> Note: This is a proposed procudure not tried yet! <<<
#
# The idea here is that we are building PWL on a RedHat 6.1
# system. Perhaps it would be an idea to simply build a package
# from binaries of the running development system. Obviously
# there won't be any compiling necessary.
#
# 1. Create a tar file containing an empty directory with the
#    name and version of the package
# 2. Place the tarfile into ./sources/
# 3. Extract the tar file into ./build_pwl/
# 4. Create the build_pwl.sh script
# 5. Create the patchfile as instructed above
# 6. This package should be treated just like the above for
#    recreating a PWL package from nonexistant sources :)
#
# >>> Note: Not tested, just proposed. Perhaps name the <<<
# >>>       package to indicate it's different, i.e. RH <<<
# >>>       appended to the package name...             <<<
# 
##################################################################
#
# Note this is a rough script. Still needs sanity checks!
# The sample entries are kept from thttpd
#
##################################################################
#
# Another note: If patches are to be applied to the sources  apply  
# these prior to creating the pwl patch, so the pwl patch is all 
# that is needed to successfully compile a package.
#
##################################################################

BIN_INSTALL="../../mnt/usr/sbin"
LIB_INSTALL="../../mnt/usr/lib"
CFG_INSTALL="../../mnt/etc"
HOME_INSTALL="../../mnt/home/htdocs"
INIT_INSTALL="../../mnt/etc/rcS.d"

# Configure and compile
./configure
make

# Cleanup install filesystem
rm -rf ../../mnt/*

# Create install directories
mkdir -p ${BIN_INSTALL}
mkdir -p ${INIT_INSTALL}
mkdir -p ${HOME_INSTALL}
mkdir -p ${HOME_INSTALL}/cgi-bin

# Copy binaries
objcopy --strip-all thttpd ${BIN_INSTALL}/thttpd
objcopy --strip-all extras/htpasswd ${BIN_INSTALL}/htpasswd

# Copy libraries
objcopy --strip-debug sample ${LIB_INSTALL}/sample

# Copy sample page
cp index.html ${HOME_INSTALL}/index.html

# Copy init script
cp 85thttpd ${INIT_INSTALL}/85thttpd

# Set permissions
chmod 755 ${BIN_INSTALL}/thttpd
chmod 755 ${BIN_INSTALL}/htpasswd
chmod 755 ${INIT_INSTALL}/85thttpd
chmod 644 ${HOME_INSTALL}/index.html
chown root.root ${BIN_INSTALL}/thttpd
chown root.root ${BIN_INSTALL}/htpasswd
chown root.root ${INIT_INSTALL}/85thttpd
chown nobody.nobody ${HOME_INSTALL}/index.html

# Create package
cd ../../mnt
tar cvpf ${CATEGORY}/${PACKAGE}.tar *

# Clean up after ourselves
rm -rf *

# Return and exit...
cd -

exit 0


