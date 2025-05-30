#!/bin/bash

set -e -x

CHOST=${macos_machine}

pushd "${PREFIX}"/bin
  ln -s clang ${CHOST}-clang
  ln -s clang-cpp ${CHOST}-clang-cpp
  if [[ "${CBUILD}" != ${CHOST} ]]; then
    ln -s clang ${CBUILD}-clang
    ln -s clang-cpp ${CBUILD}-clang-cpp
  fi
popd
