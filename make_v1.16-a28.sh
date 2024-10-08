#!/bin/sh

# set build parameters
ANCHOR_VERSION="0.28.0"
ANCHOR_HASH="ad77710fb047675dd599f6c9b0384d530aad98bfc347ab8c269ce2279b5fce5c"
CRITERION_VERSION="2.3.3"
CRITERION_HASH="ee7f92d7268563848aa3ae90bbf5df86604b8d0fb0e4942b0ecfbf6201596550"
PLATFORM_TOOLS_VERSION="1.37"
PLATFORM_TOOLS_HASH="8d5153589dbe19635affe937663cf4555a7e69a62d91ab4a1df064aaa8d5f066"
RUST_IMAGE_TAG="1.69-slim-bookworm"
SOLANA_VERSION="1.16.27"
SOLANA_HASH="c80b2246e6f67e0255865ef94e9312e1fd58ce39b3b6f9e300f37801d2a9bfc1"

# call the build process
. ./includes/build_v3.sh
