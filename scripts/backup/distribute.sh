#! /bin/bash

# scripts/distribute
#
# Creates two tar archives containing binaries and sources.
# Takes version number as commandline argument.
#
# Now creates 3 tar archives containing sources, basic binaries and
# supplementary binaries
#

usage () {
    echo ""
    echo "Usage:   distribute [version]"
    echo "Example: distribute 0.15"
    echo ""
    echo "Make sure you run the clean script first"
    echo "to get rid of build time stuff...."
    echo ""
    exit 0
}

if echo `pwd` | grep -q Embedded_Build$; then

    # Test for version
    [ -z $1 ] && usage

    cd ../

    # Create source archive
    tar czpf peeweelinux-${1}-src.tar.gz Embedded_Build

    # Create binary archive
    tar czpf peeweelinux-${1}-bin.tar.gz \
        --exclude=Embedded_Build/src/SRPMS \
        Embedded_Build

else

    # Wrong root
    echo 'This scripts needs to be run from'
    echo '     Embedded_Build'    
fi

exit 0
