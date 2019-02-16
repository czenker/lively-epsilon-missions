#!/usr/bin/env bash
set -eux

VERSION=$(git describe HEAD || echo "dev")
BUILD_DIR="_build/"

echo "Building version ${VERSION}..."

ZIPFILE="$(pwd)/release-${VERSION}.zip"
GZFILE="$(pwd)/release-${VERSION}.tar.gz"
XZFILE="$(pwd)/release-${VERSION}.tar.xz"

rm -rf _build $ZIPFILE $GZFILE $XZFILE
mkdir -p _build

echo "$VERSION" > _build/VERSION.txt

mkdir -p _build/lively_epsilon/
cp -r lively_epsilon/src/ "_build/lively_epsilon/src"
cp lively_epsilon/Readme.md lively_epsilon/LICENSE lively_epsilon/init.lua "_build/lively_epsilon/"

cp -r 01_krepios/ _build/01_krepios/
cp scenario_01_krepios.lua Readme.md LICENSE factionInfo.lua shipTemplates.lua _build/

cd _build

zip -Jr $ZIPFILE *
tar -czf $GZFILE *
tar -cjf $XZFILE *
