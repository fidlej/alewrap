
A Lua wrapper for the [Arcade Learning Environment](http://www.arcadelearningenvironment.org/).

Installation
============

    # Build Arcade Learning Environment 0.4.4 in the sibling directory.
    cd ..
    wget http://www.arcadelearningenvironment.org/wp-content/uploads/2014/04/ale_0.4.4.zip
    unzip ale_0.4.4.zip
    cd ale_0.4.4/ale_0_4
    make -f makefile.`luajit -e 'if jit.os == "OSX" then print("mac") else print("unix") end'`

    # Go back and build alewrap
    cd ../../alewrap
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DALE_INCLUDE_DIR=../../ale_0.4.4/ale_0_4/src -DALE_LIBRARY=../../ale_0.4.4/ale_0_4/libale.so ..


Running
=======

    ./run_example.sh -rom path/to/pong.bin

The example will display the observed frames.
See the [example.lua](example.lua) for the API usage.
