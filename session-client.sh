#! /bin/bash

source $(dirname $0)/session_defines

echo $UZBL_URI >> $session_file
echo "exit" >> $UZBL_FIFO
