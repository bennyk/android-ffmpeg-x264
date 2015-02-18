#!/bin/bash
pushd `dirname $0`
. settings.sh
pushd ffmpeg
make install

echo "copying private headers..."
cp ./libavformat/url.h ../out/$ARCH/include/libavformat/.
popd; popd
