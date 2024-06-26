#!/bin/sh

if [ "$SOLANA_BUILD_FRAMEWORK" = "solana" ] || [ "$SOLANA_BUILD_FRAMEWORK" = "" ]; then
	echo "Executing: cargo build-bpf --features \"$CARGO_BUILD_FEATURES\""
	cargo build-bpf --features "$CARGO_BUILD_FEATURES"
elif [ "$SOLANA_BUILD_FRAMEWORK" = "anchor" ]; then
  PATH="$PATH:/root/.cargo/bin/"
	echo "Executing: anchor build -- --features \"$CARGO_BUILD_FEATURES\""
	anchor build -- --features "$CARGO_BUILD_FEATURES"
else
	echo "Error: Invalid SOLANA_BUILD_FRAMEWORK"
fi
