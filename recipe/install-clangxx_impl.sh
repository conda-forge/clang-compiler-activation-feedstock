#!/bin/bash

set -e -x

MAJOR_VERSION=$(echo ${PKG_VERSION} | cut -f1 -d".")
CHOST=${macos_machine}
echo CHOST is ${CHOST}

mkdir -p "${PREFIX}/bin"
pushd "${PREFIX}/bin"
  ln -s clang-${MAJOR_VERSION} ${CHOST}-clang++
popd
