#!/bin/sh
FNAME=$1
NEW_ROOT="`pwgen -s 24 -1`"
COUNT="`grep -c 'ROOT-PW_CHANGE-ME!!!' $FNAME`"
sed -i 's/ROOT-PW_CHANGE-ME!!!/'$NEW_ROOT'/g' $FNAME
if [ $COUNT -gt 0 ]; then
    echo "root password for instance is $NEW_ROOT"
fi
