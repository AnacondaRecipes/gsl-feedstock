#!/bin/bash

./configure --prefix=${PREFIX}  \
            --host=${HOST}

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install

# if [[ ${HOST} =~ .*darwin.* ]]; then
#     rm "$PREFIX"/lib/libgslcblas.*
#     ln -s "$PREFIX/lib/libopenblas.dylib" "$PREFIX/lib/libgslcblas.dylib"
#     ln -s "$PREFIX/lib/libopenblas.dylib" "$PREFIX/lib/libgslcblas.0.dylib"
# elif [[ ${HOST} =~ .*linux.* ]]; then
#     rm "$PREFIX"/lib/libgslcblas.*
#     ln -s "$PREFIX/lib/libopenblas.so" "$PREFIX/lib/libgslcblas.so"
#     ln -s "$PREFIX/lib/libopenblas.so" "$PREFIX/lib/libgslcblas.so.0"
# fi
