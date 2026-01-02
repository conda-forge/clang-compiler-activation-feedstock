#!/bin/bash

set -e -x

CHOST=${macos_machine}
echo CHOST is ${CHOST}

mkdir -p "${PREFIX}/bin"
pushd "${PREFIX}/bin"
  ln -s clang++ ${CHOST}-clang++
popd
