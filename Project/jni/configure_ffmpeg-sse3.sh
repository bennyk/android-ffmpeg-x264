#!/bin/bash
pushd `dirname $0`
topdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. settings.sh

# enable minimal featureset
minimal_featureset=0

if [[ $minimal_featureset == 1 ]]; then
  echo "Using minimal featureset"
  featureflags="--disable-everything \
--enable-decoder=mjpeg --enable-demuxer=mjpeg --enable-parser=mjpeg \
--enable-demuxer=image2 --enable-muxer=mp4 --enable-encoder=libx264 --enable-libx264 \
--enable-decoder=rawvideo \
--enable-protocol=file \
--enable-hwaccels"
fi

if [[ $DEBUG == 1 ]]; then
  echo "DEBUG = 1"
  DEBUG_FLAG="--disable-stripping"
fi

pushd ffmpeg

export PKG_CONFIG_PATH=$topdir/out/${ARCH}/lib/pkgconfig
./configure $DEBUG_FLAG --enable-cross-compile \
--arch=$ARCH \
--cpu=i686 \
--target-os=linux \
--disable-stripping \
--prefix=../out/$ARCH \
--disable-neon \
--enable-version3 \
--disable-shared \
--enable-static \
--enable-gpl \
--enable-memalign-hack \
--extra-cflags="-fPIC -DANDROID -Wfatal-errors -Wno-deprecated -march=atom -msse3 -ffast-math -mfpmath=sse" \
$featureflags \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--enable-librtmp \
--enable-filter=buffer \
--enable-filter=buffersink \
--disable-demuxer=v4l \
--disable-demuxer=v4l2 \
--disable-indev=v4l \
--disable-indev=v4l2 \
--sysroot=$SYSROOT \
--cross-prefix=$CROSS_PREFIX \
--extra-cflags="-I../x264 -Ivideokit" \
--extra-libs="$LIBGCC_STATIC_LIB -lc -ldl" \
--extra-ldflags="-L../x264" \
--pkg-config=$(which pkg-config) \
--disable-amd3dnow --disable-amd3dnowext --enable-asm --enable-yasm

popd; popd
