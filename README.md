# Solana Docker

Docker Images for isolation build environment when working Solana contracts.

Only latest version of each minor version is predefined for convenient.

## Prequisites

- Operating System: Debian/Ubuntu.
- Required Tools: curl, docker, sha256sum, tar, unzip.
- Internet access.

## Build

Simply execute the pre-defined script. These script will download the requirement components from GitHub release. Nothing is compiled in your computer. All the downloaded resources can be found in **.cache** directory. For example:

```bash
./make_v1.14-a26.sh
```

Once the process is completed, a Docker image which contain the selected Solana and Anchor verson will be ready for use. For example:

```text
docker.io/library/solana-build:1.14.27-a0.26.0
```

### Further customization

You can create image for different version of Solana, Anchor based on what you need. Referring to the FAQs below to collect necessary information to create the make shell script.

Here are some technical notes:

- **build_v1.sh**, **Dockerfile.v1** are used for Solana version that use BPF SDK as the platform-tools. Which is Solana v1.14.29 and earlier.
- **build_v2.sh**, **Dockerfile.v2** are used for Solana version that use SBF SDK as the platform-tools. Which is Solana v1.15.x.
- **build_v3.sh**, **Dockerfile.v3** are used for Solana version that use new platform-tools. Which is Solana v1.16.0 and later.

## Usage

Assume that you are in project folder. Execute the following command:

```bash
docker run --rm -v "$(pwd)":"/code" -v "$(pwd)/target":"/code/target" -e SOLANA_BUILD_FRAMEWORK="solana" -e CARGO_BUILD_FEATURES="" docker.io/library/solana-build:1.14.27-a0.26.0
```

There are two environment variable to control the build process:

- SOLANA_BUILD_FRAMEWORK: "solana", "anchor". This depends on the project you're working on.
  - "solana" is for building plain-old solana project. This is default value if this variable is not supplied.
  - "anchor" is for building project with Anchor framework.
- CARGO_BUILD_FEATURES: Inject rust features flag into inner command in the Docker image.

## FAQs

### How to find hashes for components?

Most common versions of components are listed here. If you can't find the desired version here, you can download the release file and compute SHA-256 hash of the files manually.

| Component      | Version  | SHA-256                                                          |
|----------------|----------|------------------------------------------------------------------|
| Solana         | v1.14.27 | cf9affca9e9a00d770c79e5cf1df76b8ded682def421ab793db6e5aa31bea735 |
| Solana         | v1.15.2  | 6d0e92b32b3291759263cfd62dc148ff00e73602feadbf42fa252b3a052331db |
| Solana         | v1.16.27 | c80b2246e6f67e0255865ef94e9312e1fd58ce39b3b6f9e300f37801d2a9bfc1 |
| Solana         | v1.17.34 | dd726f06ce7c4d44c2457c5851214f6fc17ed20bf97abb2988aca4c9cec7d54a |
| Anchor         | v0.26.0  | bf0f6ac086ec950956490cfaad40d10a0d2a069f523ccd178710652a5cffc8cf |
| Anchor         | v0.27.0  | a3114b6d86034cc463fbb4c88815f6c2c0268d0ee2880c57ace5ebca45861296 |
| Anchor         | v0.28.0  | ad77710fb047675dd599f6c9b0384d530aad98bfc347ab8c269ce2279b5fce5c |
| Anchor         | v0.29.0  | f7b8d9435b798443bb81bdf7a1f6123c32640f9ebf05733a1e4a53999d78959a |
| bpf-tools      | v1.29    | 61ab3485168129eb2392efa4e2c7781435c9825f07c19822e46bcf5a2cd8a8d2 |
| sbf-tools      | v1.32    | 05683cd0d7bc9751b4473881d6545abf135bf59c3c3280855f4e8358f7645f6c |
| platform-tools | v1.37    | 8d5153589dbe19635affe937663cf4555a7e69a62d91ab4a1df064aaa8d5f066 |

### How to findout Rust version used to build Solana CLI?

- Before v1.15.0: https://github.com/solana-labs/solana/blob/v1.14.27/ci/rust-version.sh
- From v1.15.0 onward: https://github.com/solana-labs/solana/blob/v1.15.0/rust-toolchain.toml

### How to determine which version of platform-tools used?

Try to look for version of criterion, bpf-tools, sbf-tools, platform-tools on these files in their respective tag.

- https://github.com/solana-labs/solana/blob/v1.14.27/sdk/bpf/scripts/install.sh
- https://github.com/solana-labs/solana/blob/v1.14.27/sdk/sbf/scripts/install.sh
