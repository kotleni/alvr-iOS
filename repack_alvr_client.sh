#!/bin/bash
set -e
BUILDDIR="ALVR/target/aarch64-apple-ios/distribution"
HEADERPATH="ALVR/alvr_client_core.h"
rm -r alvrrepack ALVRClientCore.xcframework || true
mkdir -p alvrrepack/ios alvrrepack/maccatalyst alvrrepack/xros alvrrepack/xrsimulator alvrrepack/headers
cp "$BUILDDIR/libalvr_client_core.dylib" alvrrepack/ios
cp "$HEADERPATH" alvrrepack/headers

install_name_tool -id "@rpath/libalvr_client_core.dylib" alvrrepack/ios/libalvr_client_core.dylib

xcrun vtool -arch arm64 -set-build-version maccatalyst 17.0 17.0 -replace -output alvrrepack/maccatalyst/libalvr_client_core.dylib alvrrepack/ios/libalvr_client_core.dylib

xcodebuild -create-xcframework -library alvrrepack/ios/libalvr_client_core.dylib -headers alvrrepack/headers -output ALVRClientCore.xcframework
