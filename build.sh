#!/usr/bin/sh

CRITERION_VERSION="2.3.3"
PLATFORM_TOOLS_VERSION="1.29"
SOLANA_VERSION="1.14.15"
WORKING_DIR="$(pwd)"

if [ ! -d "$WORKING_DIR/.cache" ]; then
	echo "Create cache directory at $WORKING_DIR/.cache"
	mkdir -p "$WORKING_DIR/.cache"
fi
cd "$WORKING_DIR/.cache"

echo "Downloading Solana v$SOLANA_VERSION"
if [ -d "$WORKING_DIR/.cache/solana-release-$SOLANA_VERSION-x86_64-unknown-linux-gnu" ]; then
	echo "Dir solana-release-$SOLANA_VERSION-x86_64-unknown-linux-gnu is already existed. Skip downloading."
else
	curl -fSL "https://github.com/solana-labs/solana/releases/download/v$SOLANA_VERSION/solana-release-x86_64-unknown-linux-gnu.tar.bz2" -o "$WORKING_DIR/.cache/solana-release-$SOLANA_VERSION-x86_64-unknown-linux-gnu.tar.bz2"
	mkdir -p "$WORKING_DIR/.cache/solana-release-$SOLANA_VERSION-x86_64-unknown-linux-gnu"
	tar -xvf "$WORKING_DIR/.cache/solana-release-$SOLANA_VERSION-x86_64-unknown-linux-gnu.tar.bz2" -C "$WORKING_DIR/.cache/solana-release-$SOLANA_VERSION-x86_64-unknown-linux-gnu"
fi

echo "Downloading Solana Platform Tools v$PLATFORM_TOOLS_VERSION"
if [ -d "$WORKING_DIR/.cache/solana-bpf-tools-$PLATFORM_TOOLS_VERSION-linux" ]; then
	echo "Dir solana-bpf-tools-$PLATFORM_TOOLS_VERSION-linux is already existed. Skip downloading."
else
	curl -fSL "https://github.com/anza-xyz/platform-tools/releases/download/v$PLATFORM_TOOLS_VERSION/solana-bpf-tools-linux.tar.bz2" -o "$WORKING_DIR/.cache/solana-bpf-tools-$PLATFORM_TOOLS_VERSION-linux.tar.bz2"
	mkdir -p "$WORKING_DIR/.cache/solana-bpf-tools-$PLATFORM_TOOLS_VERSION-linux"
	tar -xvf "$WORKING_DIR/.cache/solana-bpf-tools-$PLATFORM_TOOLS_VERSION-linux.tar.bz2" -C "$WORKING_DIR/.cache/solana-bpf-tools-$PLATFORM_TOOLS_VERSION-linux"
fi
if [ -d "$WORKING_DIR/.cache/solana-sbf-tools-$PLATFORM_TOOLS_VERSION-linux" ]; then
	echo "Dir solana-sbf-tools-$PLATFORM_TOOLS_VERSION-linux is already existed. Skip downloading."
else
	curl -fSL "https://github.com/anza-xyz/platform-tools/releases/download/v$PLATFORM_TOOLS_VERSION/solana-sbf-tools-linux.tar.bz2" -o "$WORKING_DIR/.cache/solana-sbf-tools-$PLATFORM_TOOLS_VERSION-linux.tar.bz2"
	mkdir -p "$WORKING_DIR/.cache/solana-sbf-tools-$PLATFORM_TOOLS_VERSION-linux"
	tar -xvf "$WORKING_DIR/.cache/solana-sbf-tools-$PLATFORM_TOOLS_VERSION-linux.tar.bz2" -C "$WORKING_DIR/.cache/solana-sbf-tools-$PLATFORM_TOOLS_VERSION-linux"
fi

echo "Downloading Criterion v$CRITERION_VERSION"
if [ -d "$WORKING_DIR/.cache/criterion-$CRITERION_VERSION-linux-x86_64" ]; then
	echo "Dir criterion-$CRITERION_VERSION-linux-x86_64 is already existed. Skip downloading."
else
	curl -fSL "https://github.com/Snaipe/Criterion/releases/download/v$CRITERION_VERSION/criterion-v$CRITERION_VERSION-linux-x86_64.tar.bz2" -o "$WORKING_DIR/.cache/criterion-$CRITERION_VERSION-linux-x86_64.tar.bz2"
	mkdir -p "$WORKING_DIR/.cache/criterion-$CRITERION_VERSION-linux-x86_64"
	tar -xvf "$WORKING_DIR/.cache/criterion-$CRITERION_VERSION-linux-x86_64.tar.bz2" -C "$WORKING_DIR/.cache/criterion-$CRITERION_VERSION-linux-x86_64"
fi

cd "$WORKING_DIR"
docker build --build-arg "CRITERION_VERSION"="$CRITERION_VERSION" --build-arg "PLATFORM_TOOLS_VERSION"="$PLATFORM_TOOLS_VERSION" --build-arg "SOLANA_VERSION=$SOLANA_VERSION" -t solana-v1.14 .
