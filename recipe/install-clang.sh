#!/bin/bash

set -e -x

CHOST=${macos_machine}

pushd "${PREFIX}"/bin
  ln -s clang ${CHOST}-clang
  ln -s clang-cpp ${CHOST}-clang-cpp
  if [[ "${CBUILD}" != ${CHOST} ]] && [[ "${target_platform}" != linux-* ]]; then
    # on linux, the `clang` package already has a $TRIPLE-clang, see
    # https://github.com/conda-forge/clangdev-feedstock/pull/251
    ln -s clang ${CBUILD}-clang
    ln -s clang-cpp ${CBUILD}-clang-cpp
  fi
popd
