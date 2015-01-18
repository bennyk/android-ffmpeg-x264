echo "Building librtmp for android ..."

topdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. settings.sh

pushd ./rtmpdump/librtmp

# patch the Makefile to use an Android-friendly versioning scheme
#patch -u Makefile ${patch_root}/librtmp-Makefile.patch >> ${build_log} 2>&1 || \
#die "Couldn't patch librtmp Makefile!"

prefix=$topdir/out/$ARCH
#addi_cflags="-marm"
addi_ldflags=""

test -L "crtbegin_so.o" || ln -s ${SYSROOT}/usr/lib/crtbegin_so.o
test -L "crtend_so.o" || ln -s ${SYSROOT}/usr/lib/crtend_so.o
export XLDFLAGS="$addi_ldflags -L${prefix}/lib -L${SYSROOT}/usr/lib"
export CROSS_COMPILE=$CROSS_PREFIX
export XCFLAGS="${addi_cflags} -I${prefix}/include -isysroot ${SYSROOT}"
export INC="-I${SYSROOT}"
make prefix=\"${prefix}\" OPT= install 

# copy the versioned libraries
#cp ${prefix}/lib/lib*-+([0-9]).so ${dist_lib_root}/.
# copy the headers
#cp -r ${prefix}/include/* ${dist_include_root}/.

popd
