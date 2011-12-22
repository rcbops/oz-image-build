#!/bin/bash

LIBVIRT="/var/lib/libvirt/images/"
BASE_DIR=$(dirname $0)
LOCAL_IMAGES="$BASE_DIR/images"
LOCAL_TEMPLATES="$BASE_DIR/templates"
LOCAL_PUBLISH="$BASE_DIR/publish"

if [ -z $OZ_DEBUG ]; then
    OZ_DEBUG=0
fi

function build {
    TEMPLATE=$1
    IMAGE_NAME=$2
    DISK_NAME=$3
    CONFIG_FILE=$4

    # do a little error checking
    if [ ! -d "$LOCAL_IMAGES" ]; then
        echo "Creating images director $LOCAL_IMAGES"
        mkdir "$LOCAL_IMAGES"
    fi

    if [ ! -d "$LOCAL_PUBLISH" ]; then
        echo "Creating publish directory $LOCAL_PUBLISH"
        mkdir "$LOCAL_PUBLISH"
    fi

    if [ ! -f "$LOCAL_TEMPLATES/$TEMPLATE.tdl" ]; then
        echo "Error!  The template $LOCAL_TEMPLATES/$TEMPLATE.tdl does not exist."
        exit
    fi

    if [ -f "$BASE_DIR/fixup-root-passwords.sh" ]; then
        echo "fixing up root paswords in templates/"
        $BASE_DIR/fixup-root-passwords.sh "$LOCAL_TEMPLATES/$TEMPLATE.tdl"
    fi


    if [ -z $CONFIG_FILE ]; then
        CONFIG_FILE="$LOCAL_TEMPLATES/oz.cfg"
    fi

    if [ -f "$LOCAL_TEMPLATES/$CONFIG_FILE" ]; then
        LIBVIRT="`cat "$LOCAL_TEMPLATES/$CONFIG_FILE" | grep output_dir | awk '{print $3}'`"
    fi

    echo "Starting the build of $IMAGE_NAME from $LOCAL_TEMPLATES/$TEMPLATE.tdl.  This will take a while Shep!"
    /usr/bin/oz-install -c "$LOCAL_TEMPLATES/$CONFIG_FILE" -d$OZ_DEBUG -x "$LOCAL_TEMPLATES/$TEMPLATE.xml" -p -u "$LOCAL_TEMPLATES/$TEMPLATE.tdl"
    if [ $? -eq 0 ]; then
        echo "build successfull"

        echo -n "converting raw disk to compressed qcow..."
        CONVERT_IMG="`echo $DISK_NAME | sed 's/qcow2/dsk/g'`"
        qemu-img convert -c -O qcow2 "$LIBVIRT/$DISK_NAME" "$LOCAL_PUBLISH/$IMAGE_NAME"
        if [ $? -ne 0 ]; then
            echo "failed"
            echo "arg1 = $LIBVIRT/$CONVERT_IMG"
            echo "arg2 = $LOCAL_PUBLISH/$IMAGE_NAME"
            exit $?
        fi
        echo "done."

        echo -n "removing old image $IMAGE_NAME..."
        rm -f "$LOCAL_IMAGES/$IMAGE_NAME"
        if [ $? -ne 0 ]; then
            echo "failed"
            echo "arg1 = $LOCAL_IMAGES/$IMAGE_NAME"
            exit $?
        fi
        echo "done"
        echo "Build complete.  Your image is located at $LOCAL_PUBLISH/$IMAGE_NAME"
        exit 0
    else
        echo "Build failed"
        exit 1
    fi
}

build $1 $2 $3 $4
exit 0
