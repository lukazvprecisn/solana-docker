#!/bin/sh

if [ "${SOLANA_BUILD_FRAMEWORK}" = "solana" ] || [ "${SOLANA_BUILD_FRAMEWORK}" = "" ]; then
	echo "Executing: cargo build-sbf --features \"${CARGO_BUILD_FEATURES}\""
	cargo build-sbf --features "${CARGO_BUILD_FEATURES}"
elif [ "${SOLANA_BUILD_FRAMEWORK}" = "anchor" ]; then
	echo "Executing: anchor build -- --features \"${CARGO_BUILD_FEATURES}\""
	anchor build -- --features "${CARGO_BUILD_FEATURES}"
else
	echo "Error: Invalid SOLANA_BUILD_FRAMEWORK"
fi
