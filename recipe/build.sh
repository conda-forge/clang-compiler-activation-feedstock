#!/bin/bash

CHOST=${macos_machine}

FINAL_CPPFLAGS="-D_FORTIFY_SOURCE=2"
FINAL_CFLAGS="-ftree-vectorize -fPIC -fstack-protector-strong -O2 -pipe"
FINAL_CXXFLAGS="-ftree-vectorize -fPIC -fstack-protector-strong -O2 -pipe -stdlib=libc++ -fvisibility-inlines-hidden -fmessage-length=0"
if [[ "${uname_machine}" == "x86_64" ]]; then
  FINAL_CFLAGS="-march=core2 -mtune=haswell -mssse3 $FINAL_CFLAGS"
  FINAL_CXXFLAGS="-march=core2 -mtune=haswell -mssse3 $FINAL_CXXFLAGS"
fi
# These are the LDFLAGS for when the linker is being driven by a compiler, i.e. with -Wl,
FINAL_LDFLAGS="-Wl,-headerpad_max_install_names -Wl,-dead_strip_dylibs"
# These are the LDFLAGS for when the linker is being called directly, i.e. without -Wl,
FINAL_LDFLAGS_LD="-headerpad_max_install_names -dead_strip_dylibs"
FINAL_DEBUG_CFLAGS="-Og -g -Wall -Wextra"
FINAL_DEBUG_CXXFLAGS="-Og -g -Wall -Wextra"

if [[ "$target_platform" == "$cross_target_platform" ]]; then
  CONDA_BUILD_CROSS_COMPILATION=""
else
  CONDA_BUILD_CROSS_COMPILATION="1"
fi

if [[ "$target_platform" == linux* ]]; then
  CC_FOR_BUILD=${CBUILD}-gcc
  CPP_FOR_BUILD=${CBUILD}-cpp
  CXX_FOR_BUILD=${CBUILD}-g++
else
  CC_FOR_BUILD=${CBUILD}-clang
  CPP_FOR_BUILD=${CBUILD}-clang-cpp
  CXX_FOR_BUILD=${CBUILD}-clang++
fi

find "${RECIPE_DIR}" -name "*activate*.sh" -exec cp {} . \;

find . -name "*activate*.sh" -exec sed -i.bak "s|@CHOST@|${CHOST}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CBUILD@|${CBUILD}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CPPFLAGS@|${FINAL_CPPFLAGS}|g"             "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CC_FOR_BUILD@|${CC_FOR_BUILD}|g"           "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CPP_FOR_BUILD@|${CPP_FOR_BUILD}|g"         "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CXX_FOR_BUILD@|${CXX_FOR_BUILD}|g"         "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CFLAGS@|${FINAL_CFLAGS}|g"                 "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@DEBUG_CFLAGS@|${FINAL_DEBUG_CFLAGS}|g"     "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CXXFLAGS@|${FINAL_CXXFLAGS}|g"             "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@DEBUG_CXXFLAGS@|${FINAL_DEBUG_CXXFLAGS}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@DEBUG_CXXFLAGS@|${FINAL_DEBUG_CXXFLAGS}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@LDFLAGS@|${FINAL_LDFLAGS}|g"               "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@LDFLAGS_LD@|${FINAL_LDFLAGS_LD}|g"         "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CONDA_BUILD_CROSS_COMPILATION@|${CONDA_BUILD_CROSS_COMPILATION}|g"         "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@_PYTHON_SYSCONFIGDATA_NAME@|${FINAL_PYTHON_SYSCONFIGDATA_NAME}|g"  "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@UNAME_MACHINE@|${uname_machine}|g"         "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@MESON_CPU_FAMILY@|${meson_cpu_family}|g"         "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@UNAME_KERNEL_RELEASE@|${uname_kernel_release}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@TARGET_PLATFORM@|${cross_target_platform}|g"     "{}" \;
find . -name "*activate*.sh.bak" -exec rm "{}" \;
