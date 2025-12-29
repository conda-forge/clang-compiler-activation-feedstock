#!/bin/bash

set -e -x

CHOST=${macos_machine}
echo CHOST is ${CHOST}

pushd "${PREFIX}"/bin
  ln -s clang++ ${CHOST}-clang++
popd
