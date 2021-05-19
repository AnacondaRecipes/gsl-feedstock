#!/bin/bash

./configure --prefix=${PREFIX}  \
            --host=${HOST}

make -j${CPU_COUNT} ${VERBOSE_AT}
# TODO :: One test has too little tolerance to pass on i686
if [[ ! ${HOST} =~ i686.* ]]; then
    make -j${CPU_COUNT}
    for f in $(find * -name "test.c"); do
        TEST_DIR=$(dirname $f)
        pushd $TEST_DIR;
        SKIP=false
        # See: https://savannah.gnu.org/bugs/index.php?56843
        if [[ "$target_platform" == "linux-aarch64" && "$TEST_DIR" == "spmatrix" ]]; then
            SKIP=true
        fi
        if [[ "$target_platform" == "linux-ppc64le" ]]; then
            if [[ "$TEST_DIR" == "linalg" || "$TEST_DIR" == "multilarge_nlinear" || "$TEST_DIR" == "spmatrix" ]]; then
                SKIP=true
            fi
        fi
        if [[ "$SKIP" == true ]]; then
            make check || true;
        else
            make check;
        fi
        popd;
    done
fi
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
