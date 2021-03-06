#!/bin/bash

set -ex

FUZDIR=$PWD
source ${XRAY_GENHEADER}

echo '`define SEED 32'"'h$(echo $1 | md5sum | cut -c1-8)" > setseed.vh

${XRAY_VIVADO} -mode batch -source $FUZDIR/generate.tcl | tee vivado_stdout.log | grep "FUZ[^:]\+:"

${XRAY_BITREAD} -F $XRAY_ROI_FRAMES -o design.bits -z -y design.bit
python3 $FUZDIR/generate.py

