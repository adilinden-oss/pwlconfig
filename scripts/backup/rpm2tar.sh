#!/bin/bash

#
# rpm2tar
#
# Convert binary rpm to tar
#
# To be executed from the Embedded_Build directory. The script will
# extract the rpm passed on the command line into the mnt directory
# and subsequently create a tar file in the package directory.
# Subdirectories are created according to the summary tag defined
# in the rpm.
#
 
#
# Variables
#
MNT_DIR=`pwd`
WRK_DIR="$MNT_DIR/mnt"
RPM_DIR="$MNT_DIR/src/RPMS/i386"
RDB_DIR="/var/lib/rpm"
TAR_DIR="$MNT_DIR/packages"

#
# Uncomment the desired verbosity level 
#
V=""
#V="v"
#V="vv"

#
# Extract RPM
#
extract_rpm () {

echo -e "Extracting:\n$RPM_PKG"

# Clean up
rm -rf $WRK_DIR

# Create rpm database dir
mkdir -p ${WRK_DIR}/${RDB_DIR}

# Init Database
rpm --initdb --root $WRK_DIR

# Unpack RPM
rpm -i${V}h --noscripts --root $WRK_DIR --force --nodeps $RPM_PKG

}

#
# Create tar file
#
tar_rpm () {

# Get the group from the package
# converting any whitespace into underscores
TAR_LOC=`rpm -qp --queryformat '%{group}' $RPM_PKG | tr [:blank:] _`

# Create the file name
TAR_NAME=`rpm -qp --queryformat '%{name}-%{version}-%{release}' $RPM_PKG`

# Create target directory
mkdir -p ${TAR_DIR}/${TAR_LOC}

# Assemble the whole thing for clearness
TAR_FULL="${TAR_DIR}/${TAR_LOC}/${TAR_NAME}.tar"

echo -e "Creating tar package:\n$TAR_FULL"

# Create the tar file
tar c${V}pf $TAR_FULL --exclude=".$RDB_DIR" --directory="$WRK_DIR" ./

}

#
# Make sure we're in the right directory
#
if echo $MNT_DIR | grep -q Embedded_Build$; then
    # Determine what's been passed to us
    case $1 in
    all)
        # Do the whole RPM directory
        echo "Creating a tar package from each rpm.... "
        echo -n "Are you sure you want to proceed...(y/n) "
        read PROMPT
        if [ "$PROMPT" = "y" ]; then
            echo "As you desire.... hang on...."

            # Parse all rpm
            for RPM_PKG in `du -a $RPM_DIR | cut -f 2`; do

                # Check to if it's an rpm
                if echo $RPM_PKG | grep -q rpm$; then
                    extract_rpm
                    tar_rpm
                fi
            done
        else
            # No was the answer
            echo "Chicken....!"
        fi
        ;;
    *rpm)
        # Just do the RPM specified
        RPM_PKG=${RPM_DIR}/$1
	if [ -e "$RPM_PKG" ]; then
             extract_rpm
             tar_rpm
        fi
        ;;
    *)
        # Nothing to do
        echo "Usage: rpm2tar.sh [ all | <rpmfile> ]"
        ;;
    esac
else
    # Wrong dir!
    echo "This script has to be run from Embedded_Build...."
fi
