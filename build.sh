#!/bin/bash

set -x

cp /lib/x86_64-linux-gnu/libncurses.so.5 .

gcc main.c -o main -ldl
gcc -fPIC -shared lib.c  -Wl,-rpath='$ORIGIN' -lncurses -o A.so
gcc -fPIC -shared lib.c -lncurses -o B.so


if [ "x$1" = "x--workaround" ]; then
    mv ./libncurses.so.5 ./libncurses-asdf.so.5
    # This requires a patchelf containing a fix for
    #   https://github.com/NixOS/patchelf/issues/84
    # e.g., https://github.com/njsmith/patchelf
    patchelf --debug --set-soname libncurse-asdf.so.5 libncurses-asdf.so.5
    patchelf --debug --replace-needed libncurses.so.5 libncurses-asdf.so.5 ./A.so
fi
