#!/bin/bash

# Configuration - Change these to match your project
PODSPEC_NAME="TapMindSDK.podspec"
VERSION=$(grep -E 's.version\s+=' "$PODSPEC_NAME" | cut -d '"' -f 2 | cut -d "'" -f 2)

echo "🚀 Starting publication process for $PODSPEC_NAME version $VERSION..."

# 1. Lint the Podspec locally
echo "🔍 Validating podspec..."
if pod lib lint --allow-warnings; then
    echo "✅ Lint passed!"
else
    echo "❌ Lint failed. Please fix errors before publishing."
    exit 1
fi

# 2. Git Tagging
echo "🏷️  Tagging version $VERSION in git..."
git add .
#git commit -m "Release version $VERSION"
git commit -m "Removed logs"
git tag "$VERSION"
git push origin main
git push origin "$VERSION"

# 3. Push to CocoaPods Trunk
echo "📤 Pushing to CocoaPods Trunk..."
pod trunk push "$PODSPEC_NAME" --allow-warnings

echo "🎉 Successfully published $PODSPEC_NAME ($VERSION)!"
