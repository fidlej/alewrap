#!/bin/sh
ALE_HOME="../ale_0.4.4/ale_0_4"
export LD_LIBRARY_PATH="$ALE_HOME"
export DYLD_LIBRARY_PATH="$LD_LIBRARY_PATH"
exec qlua ./example.lua "$@"

