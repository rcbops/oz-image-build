#!/bin/bash

LIBVIRT="/var/lib/libvirt/images/"
BASE_DIR=$(dirname $0)
LOCAL_IMAGES="$BASE_DIR/images"
LOCAL_TEMPLATES="$BASE_DIR/templates"
LOCAL_PUBLISH="$BASE_DIR/publish"

TEMPLATE=$1
IMAGE_NAME=$2
DISK_NAME=$3
CONFIG_FILE=$4

if [ -z $OZ_DEBUG ]; then
    OZ_DEBUG=0
fi

function dl {
    MSG=$1
    LVL=${2-0}

    if [ $LVL -lt $OZ_DEBUG ]; then
        echo "`date`: $LVL: $IMAGE_NAME: $MSG"
    fi
}

function build {

    # do a little error checking
    if [ ! -d "$LOCAL_IMAGES" ]; then
        dl "Creating images directory $LOCAL_IMAGES",1 
        mkdir "$LOCAL_IMAGES"
    fi

    if [ ! -d "$LOCAL_PUBLISH" ]; then
        dl "Creating publish directory $LOCAL_PUBLISH",1 
        mkdir "$LOCAL_PUBLISH"
    fi

    if [ ! -f "$LOCAL_TEMPLATES/$TEMPLATE.tdl" ]; then
        dl "Error!  The template file $LOCAL_TEMPLATES/$TEMPLATE.tdl does not exist",0 
        exit 1
    fi

    if [ -f "$BASE_DIR/fixup-root-passwords.sh" ]; then
        dl "fixing up root paswords in $LOCAL_TEMPLATES/$TEMPLATE.tdl",1
        PASS=`$BASE_DIR/fixup-root-passwords.sh "$LOCAL_TEMPLATES/$TEMPLATE.tdl" $OZ_DEBUG`
        dl "Password for instance is $PASS",0
    fi

    if [ -z $CONFIG_FILE ]; then
        if [ -f "$LOCAL_TEMPLATES/oz.cfg" ]; then
            CONFIG_FILE="$LOCAL_TEMPLATES/oz.cfg"
        else
            CONFIG_FILE="/etc/oz/oz.cfg"
        fi
        dl "CONFIG_FILE variable empty - setting to $CONFIG_FILE",1
    fi

    if [ -f "$CONFIG_FILE" ]; then
        LIBVIRT="`cat "$CONFIG_FILE" | grep output_dir | awk '{print $3}'`"
    fi

    dl "Starting the build of $IMAGE_NAME ont $DISK_NAME from $LOCAL_TEMPLATES/$TEMPLATE.tdl.  This will take a while Shep!",1
    dl "/usr/bin/oz-install -c \"$CONFIG_FILE\" -d$OZ_DEBUG -x \"$LOCAL_TEMPLATES/$TEMPLATE.xml\" -p -u \"$LOCAL_TEMPLATES/$TEMPLATE.tdl\"",2
    /usr/bin/oz-install -c "$CONFIG_FILE" -d$OZ_DEBUG -x "$LOCAL_TEMPLATES/$TEMPLATE.xml" -p -u "$LOCAL_TEMPLATES/$TEMPLATE.tdl"
    if [ $? -eq 0 ]; then
        dl "build successfull",1

        dl "converting raw disk to compressed qcow...",1
        CONVERT_IMG="`echo $DISK_NAME | sed 's/qcow2/dsk/g'`"
        qemu-img convert -c -O qcow2 "$LIBVIRT/$DISK_NAME" "$LOCAL_PUBLISH/$IMAGE_NAME"
        if [ $? -ne 0 ]; then
            dl "Image conversion failed",1
            dl "arg1 = $LIBVIRT/$CONVERT_IMG",2
            dl "arg2 = $LOCAL_PUBLISH/$IMAGE_NAME",2
            exit $?
        fi
        dl "Image conversion complete",1

        dl "Removing old image $IMAGE_NAME",1
        rm -f "$LOCAL_IMAGES/$IMAGE_NAME"
        if [ $? -ne 0 ]; then
            dl "ERROR: Could not delete $LOCAL_IMAGES/$IMAGE_NAME",1
            dl "arg1 = $LOCAL_IMAGES/$IMAGE_NAME",2
            exit $?
        fi
        dl "Build complete.  Your image is located at $LOCAL_PUBLISH/$IMAGE_NAME",0
        exit 0
    else
        dl "ERROR: Build failed",0
        exit 1
    fi
}

build
exit 0
