#!/bin/sh

LIBVIRT="/var/lib/libvirt/images/"
BASE_DIR=$(dirname $0)
LOCAL_IMAGES="$BASE_DIR/images"
LOCAL_TEMPLATES="$BASE_DIR/templates"

function usage {
    echo "Usage"
    echo "-----"
    echo ""
    echo "build.sh <type>"
    echo ""
    echo "f15      :  Fedora 15 X86_64 image"
    echo "f16      :  Fedora 16 X86_64 image"    
    echo "centos60 :  CentOS 6.1 X86_64 image"
    echo "  rhel56 :  RedHat 5.6 X86_64 image"
    echo ""
}

function build {
    TEMPLATE=$1
    IMAGE_NAME=$2
    DISK_NAME=$3
    CONFIG_FILE=$4

    # do a little error checking
    if [ ! -d $LOCAL_IMAGES ]; then
        echo "Creating images director $LOCAL_IMAGES"
        mkdir $LOCAL_IMAGES
    fi

    if [ ! -f $LOCAL_TEMPLATES/$TEMPLATE.tdl ]; then
        echo "Error!  The template $LOCAL_TEMPLATES/$TEMPLATE.tdl does not exist."
        exit
    fi

    if [ -z $CONFIG_FILE ]; then
        CONFIG_FILE="/etc/oz/oz.cfg"
    fi

    echo "Starting the build of $IMAGE_NAME from $LOCAL_IMAGES/$TEMPLATE.tdl.  This will take a while Shep!"
    /usr/bin/oz-install -c $LOCAL_TEMPLATES/$CONFIG_FILE -d2 -x $LOCAL_TEMPLATES/$TEMPLATE.xml -p -u $LOCAL_TEMPLATES/$TEMPLATE.tdl
    if [ $? -eq 0 ]; then
        echo "build successfull"
        echo -n "removing old image $IMAGE_NAME..."
        rm -f $LOCAL_IMAGES/$IMAGE_NAME
        if [ $? -ne 0 ]; then
            echo "failed"
            exit $?
        fi
        echo "done"

        echo -n "converting raw disk to qcow..."
        qemu-img convert -O qcow2 $LIBVIRT/$DISK_NAME $LOCAL_IMAGES/$IMAGE_NAME
        if [ $? -ne 0 ]; then
            echo "failed"
            exit $?
        fi
        echo "done."

        echo -n "compressing the compressed qcow - trust me - it does work..."
        gzip -c $LOCAL_IMAGES/$IMAGE_NAME > $LOCAL_IMAGES/$IMAGE_NAME.gz
        echo "done."

        echo "Build complete.  Your image is located at $LOCAL_IMAGES/$IMAGE_NAME"
    else
        echo "Build failed"
    fi
}

## start of script

# fixup the root passwords automagically if the script exists
# this script is a simple shell script to change the password
# token in the templates to your own - either real or generate
# from pwgen
# TODO: if the script doesn't exist then call pwgen, change it
# in the template, and then build the image while reporting
# the root password to the caller of the script
if [ -f $BASE_DIR/fixup-root-passwords.sh ]; then
    echo "fixing up root paswords in templates/"
    $BASE_DIR/fixup-root-passwords.sh
fi

case "$1" in
    f16)
        build f16 "fedora16_x86_64.img" "fedora16_x86_64.dsk"
        ;;
    f15)
        build f15 "fedora15_x86_64.img" "fedora15_x86_64.dsk"
        ;;
    centos60)
        build centos60 "centos60_x86_64.img" "centos60_x86_64.dsk" "centos60.oz.cfg"
        ;;
    rhel56)
        build rhel56 "rhel56_x86_64.img" "rhel56_x86_64.dsk"
        ;;
    help)
        usage
        exit
        ;;
    *)
        echo ""
        echo "** Unknown image type: $1"
        echo ""
        usage
        exit
        ;;
esac
