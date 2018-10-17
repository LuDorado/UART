#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2.2 (64-bit)
#
# Filename    : compile.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for compiling the simulation design source files
#
# Generated by Vivado on Fri Oct 12 18:08:00 -03 2018
# SW Build 2348494 on Mon Oct  1 18:25:39 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: compile.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
echo "xvlog --incr --relax -prj top_vlog.prj"
ExecStep xvlog --incr --relax -prj top_vlog.prj 2>&1 | tee compile.log
