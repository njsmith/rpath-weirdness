#!/bin/bash

set -x

cp /lib/x86_64-linux-gnu/libncurses.so.5 .

gcc main.c -o main -ldl
gcc -fPIC -shared lib.c  -Wl,-rpath='$ORIGIN' -lncurses -o A.so
gcc -fPIC -shared lib.c -lncurses -o B.so


if [ "x$1" = "x--workaround" ]; then
    mv ./libncurses.so.5 ./libncurses-asdf.so.5
    # This requires patchelf 0.9, which is not yet in Debian
    # Can install from https://github.com/NixOS/patchelf
    patchelf --set-soname libncurse-asdf.so.5 libncurses-asdf.so.5
    patchelf --replace-needed libncurses.so.5 libncurses-asdf.so.5 ./A.so
fi