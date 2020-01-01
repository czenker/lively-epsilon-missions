#!/usr/bin/env bash
set -eux

VERSION=$(git describe --tags HEAD || echo "dev")
BUILD_DIR="_build/"

echo "Building version ${VERSION}..."

ZIPFILE="$(pwd)/lively-epsilon-missions-${VERSION}.zip"
GZFILE="$(pwd)/lively-epsilon-missions-${VERSION}.tar.gz"
XZFILE="$(pwd)/lively-epsilon-missions-${VERSION}.tar.xz"

rm -rf _build $ZIPFILE $GZFILE $XZFILE
mkdir -p _build

echo "$VERSION" > _build/VERSION.txt

mkdir -p _build/lively_epsilon/
cp -r lively_epsilon/src/ "_build/lively_epsilon/src"
cp lively_epsilon/Readme.md lively_epsilon/LICENSE lively_epsilon/init.lua "_build/lively_epsilon/"

cp -r 01_krepios/ _build/01_krepios/
cp -r names/ _build/names/
cp -r lang/ _build/lang/
cp -r resources/ _build/resources/
mkdir _build/docs
cp docs/*.adoc _build/docs
cp -r docs/_build _build/docs/html
cp scenario_01_krepios.lua Readme.md LICENSE factionInfo.lua shipTemplates.lua model_data.lua Changelog.md _build/

cd _build

zip -Jr $ZIPFILE *
tar -czf $GZFILE *
tar -cjf $XZFILE *
