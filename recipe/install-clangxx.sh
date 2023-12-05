#!/bin/bash

set -e -x

CHOST=${macos_machine}
echo CHOST is ${CHOST}

pushd "${PREFIX}"/bin
  ln -s clang++ ${CHOST}-clang++
  if [[ "${CHOST}" != "${CBUILD}" ]] && [[ "${target_platform}" != linux-* || ${version} == "15.0.7" ]]; then
    # on linux, the `clangxx` package already has a $TRIPLE-clang++, see
    # https://github.com/conda-forge/clangdev-feedstock/pull/251
    ln -s clang++ ${CBUILD}-clang++
  fi
popd
