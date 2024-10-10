#!/bin/bash

set -e -x

CHOST=${macos_machine}

pushd "${PREFIX}"/bin
  ln -s clang ${CHOST}-clang
  ln -s clang-cpp ${CHOST}-clang-cpp
  if [[ "${CBUILD}" != ${CHOST} ]] && [[ "${target_platform}" != linux-* || ( ${version} != "17.0.6" && ${version} != "18.1.8") ]]; then
    # before v19.1.1, `clang` on linux already had this symlink, see
    # https://github.com/conda-forge/clangdev-feedstock/pull/322
    ln -s clang ${CBUILD}-clang
    ln -s clang-cpp ${CBUILD}-clang-cpp
  fi
popd
