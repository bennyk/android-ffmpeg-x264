#!/bin/bash

function die {
  echo "$1 failed" && exit 1
}


./make_pkgconfig.sh || die "pkgconfig make failed!"
./make_openssl.sh || die "openssl make failed!"
./make_librtmp.sh || die "librtmp make failed!"
./configure_x264.sh || die "X264 configure"
./make_x264.sh || die "X264 make"
./configure_ffmpeg.sh || die "FFMPEG configure"
./make_ffmpeg.sh || die "FFMPEG make"
