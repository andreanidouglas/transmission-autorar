#!/bin/sh
cd $PWD

sh build_extract.sh > extract.sh 2> /dev/null

echo ======================================================= >> extract_log.sh
echo date >> extract_log.sh
sh extract.sh >> extract_log.sh 2> /dev/null
