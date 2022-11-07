readonly CUR_DIR="$(dirname "$(realpath -s "$0")")"

set -e

cd "${CUR_DIR}" 

sh "bootstrap.sh"

cd "../"

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

echo "##Install lib"
cmake --install ./ios-cmake-gen/./ --config Release --prefix ./ot-commissioner-release

open "ot-commissioner-release"

echo "##DONE!!!!!!!!!!"