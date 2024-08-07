#!/bin/sh

# set build parameters
ANCHOR_VERSION="0.26.0"
CRITERION_VERSION="2.3.3"
PLATFORM_TOOLS_VERSION="1.29"
RUST_IMAGE_TAG="1.64-slim-bullseye"
SOLANA_VERSION="1.14.27"

# call the build process
. ./includes/build_v1.sh
