#!/bin/bash

set -e -x

MAJOR_VERSION=$(echo ${PKG_VERSION} | cut -f1 -d".")
CHOST=${macos_machine}

pushd "${PREFIX}"/bin
  ln -s clang-${MAJOR_VERSION} ${CHOST}-clang
  ln -s clang-${MAJOR_VERSION} ${CHOST}-clang-cpp
popd
