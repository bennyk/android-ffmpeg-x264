#!/bin/sh

echo "Creating pkgconfig overrides"

. settings.sh

topdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

pushd pkgconfig-overrides
make prefix=$topdir/out/${ARCH}
popd

