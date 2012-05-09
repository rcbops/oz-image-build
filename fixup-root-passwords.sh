#!/bin/sh
FNAME=$1
OZ_DEBUG=$2
NEW_ROOT="`pwgen -s 24 -1`"
CUR_ROOT=`grep rootpw $FNAME | awk -F'[<|>]' '{print $3}'`
if [ "$CUR_ROOT" = 'ROOT-PW_CHANGE-ME!!!' ]; then
    sed 's/ROOT-PW_CHANGE-ME!!!/'$NEW_ROOT'/g' $FNAME
fi
