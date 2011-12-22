#!/bin/sh
FNAME=$1
NEW_ROOT="`pwgen -s 24 -1`"
sed -i 's/ROOT-PW_CHANGE-ME!!!/'$NEW_ROOT'/g' $FNAME
