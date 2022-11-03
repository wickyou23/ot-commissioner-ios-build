readonly CUR_DIR="$(dirname "$(realpath -s "$0")")"
readonly MIN_CMAKE_VERSION="3.10.1"

set -e

echo "##Install packages"
arch -arm64 brew update
arch -arm64 brew install coreutils \
                        readline \
                        cmake \
                        ninja \
                        swig@4 \
                        llvm@11 \
                        lcov && true

echo "##Install latest cmake"
match_version() {
    local current_version=$1
    local required_version=$2
    local min_version

    min_version="$(printf '%s\n' "$required_version" "$current_version" | sort -V | head -n1)"
    if [ "${min_version}" = "${required_version}" ]; then
        return 0
    else
        return 1
    fi
}

match_version "$(cmake --version | grep -E -o '[0-9].*')" "${MIN_CMAKE_VERSION}" || {
    arch -arm64 brew unlink cmake
    arch -arm64 brew install cmake --HEAD
}

cd "${CUR_DIR}" && cd "../"

mkdir -p "ios-build" && cd "ios-build"

if [ -d "ot-commissioner-release" ]; then
    echo "##Remove old release"
    rm -rf "ot-commissioner-release"
fi

if [ ! -d "ios-cmake" ]; then
    echo "##ios-cmake not found"
    git clone https://github.com/leetal/ios-cmake.git
else
    echo "##ios-cmake already"
fi

mkdir -p "ios-cmake-gen" && cd "ios-cmake-gen"

echo "##CMake is building..."
cmake ../../ -G Xcode -DCMAKE_TOOLCHAIN_FILE=../ios-cmake/ios.toolchain.cmake -DPLATFORM=OS64 -DENABLE_BITCODE=FALSE

echo "##CMake builds xcode project..."
cmake --build . --config Release

cd  "../" && mkdir -p "ot-commissioner-release"
cp "ios-cmake-gen/src/library/Release-iphoneos/libcommissioner.a" "ot-commissioner-release"
cp -a "../include" "ot-commissioner-release"
open "ot-commissioner-release"

echo "##DONE!!!!!!!!!!"