
. settings.sh

echo "Building openssl-android ..."

pushd openssl-android
${NDK}/ndk-build
popd

dist_lib_root=./out/${ARCH}/lib
dist_bin_root=./out/${ARCH}/bin
dist_include_root=./out/${ARCH}/include

mkdir -p ${dist_lib_root}
mkdir -p ${dist_bin_root}
mkdir -p ${dist_include_root}

echo "Installing openssl-android ..."

# copy the versioned libraries
cp ./openssl-android/libs/${ARCH}/lib*.so ${dist_lib_root}/.
# copy the executables
cp ./openssl-android/libs/${ARCH}/openssl ${dist_bin_root}/.
cp ./openssl-android/libs/${ARCH}/ssltest ${dist_bin_root}/.
# copy the headers
cp -r ./openssl-android/include/* ${dist_include_root}/.

