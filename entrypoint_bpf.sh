#!/bin/sh

if [ ! -z "${ANCHOR_BUILD_NO_IDL}" ]; then
	ANCHOR_BUILD_FLAGS="${ANCHOR_BUILD_FLAGS} --no-idl"
fi
if [ ! -z "${CARGO_BUILD_FEATURES}" ]; then
	CARGO_BUILD_FLAGS="${CARGO_BUILD_FLAGS} --features ${CARGO_BUILD_FEATURES}"
fi

if [ "${SOLANA_BUILD_FRAMEWORK}" = "solana" ] || [ "${SOLANA_BUILD_FRAMEWORK}" = "" ]; then
	set -x
	cargo build-bpf ${CARGO_BUILD_FLAGS}
elif [ "${SOLANA_BUILD_FRAMEWORK}" = "anchor" ]; then
	set -x
	anchor build ${ANCHOR_BUILD_FLAGS} -- ${CARGO_BUILD_FLAGS}
else
	echo "Error: Invalid SOLANA_BUILD_FRAMEWORK"
fi
