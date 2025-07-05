#!/bin/bash
# Official Termux installer for DexDL

echo "Checking Termux environment..."
if [ ! -d "$PREFIX" ]; then
    echo "Error: Must run in Termux!"
    exit 1
fi

echo "Installing dependencies..."
pkg install -y libjpeg-turbo libpng || {
    echo "Failed to install required libraries"
    exit 1
}

echo "Downloading DexDL..."
BIN_URL="https://github.com/UnKnowNModder/DexDL/raw/master/dexdl"
wget -q "$BIN_URL" -O "$PREFIX/bin/dexdl" && \
chmod +x "$PREFIX/bin/dexdl" && \
echo "Success! Run examples below:" || {
    echo "Download failed - check URL: $BIN_URL"
    exit 1
}

echo "
Usage examples:
  dexdl 3bb0279f-a01d-4aa4-93e4-305800f4b83e
  dexdl https://mangadex.org/title/3bb0279f.../akatsuki-no-yona
"
