# First set base image to Rust built on Debian-based distro
FROM rust:1.64-slim-bullseye

# Declare arugments
ARG ANCHOR_VERSION
ARG CRITERION_VERSION
ARG PLATFORM_TOOLS_VERSION
ARG SOLANA_VERSION

# Set working directory
WORKDIR /code

# Predefine environment variables
ENV PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

# Install Solana binaries
COPY "./.cache/solana-release-${SOLANA_VERSION}-x86_64-unknown-linux-gnu" "/root/.local/share/solana/install/releases/${SOLANA_VERSION}"
COPY "./.cache/solana-bpf-tools-${PLATFORM_TOOLS_VERSION}-linux" "/root/.cache/solana/v${PLATFORM_TOOLS_VERSION}/bpf-tools"
COPY "./.cache/criterion-${CRITERION_VERSION}-linux-x86_64/criterion-v${CRITERION_VERSION}" "/root/.cache/solana/v${CRITERION_VERSION}/criterion"
COPY --chmod=755 "./.cache/anchor-cli-${ANCHOR_VERSION}/package/anchor" "/usr/local/cargo/bin/anchor"
COPY --chmod=755 "./entrypoint.sh" "/root/"

# Wire up all component
RUN mkdir "/root/.local/share/solana/install/releases/${SOLANA_VERSION}/solana-release/bin/sdk/bpf/dependencies" \
  && ln -s "/root/.local/share/solana/install/releases/${SOLANA_VERSION}/solana-release" "/root/.local/share/solana/install/active_release" \
  && ln -s "/root/.cache/solana/v${PLATFORM_TOOLS_VERSION}/bpf-tools" "/root/.local/share/solana/install/releases/${SOLANA_VERSION}/solana-release/bin/sdk/bpf/dependencies/bpf-tools" \
  && ln -s "/root/.cache/solana/v${CRITERION_VERSION}/criterion" "/root/.local/share/solana/install/releases/${SOLANA_VERSION}/solana-release/bin/sdk/bpf/dependencies/criterion"

# Execute build process
ENTRYPOINT ["/root/entrypoint.sh"]
