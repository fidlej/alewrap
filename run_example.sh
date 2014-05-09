#!/bin/sh
ALE_HOME="../ale_0.4.4/ale_0_4"
export LD_LIBRARY_PATH="$ALE_HOME:build/alewrap"
export DYLD_LIBRARY_PATH="$LD_LIBRARY_PATH"
exec qth ./example.lua "$@"

