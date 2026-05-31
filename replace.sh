#/bin/bash
# This script replaces the placeholder WORKING_DIR_PATH in the p-mariadb.build file with the actual working directory path.
WORKING_DIR=$(dirname "$(realpath "$0")")
cp $WORKING_DIR/quadlet/* $WORKING_DIR/tmp/
sed -i "s|WORKING_DIR_PATH|$WORKING_DIR|g" $WORKING_DIR/tmp/*
