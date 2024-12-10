# Use an official lightweight image with Rust
FROM rust:latest

# Install required dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    protobuf-compiler \
    libssl-dev \
    pkg-config \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
WORKDIR /root/.nexus/
RUN git clone https://github.com/nexus-xyz/network-api

# Checkout the latest tag
WORKDIR /root/.nexus/network-api
RUN git -c advice.detachedHead=false checkout $(git rev-list --tags --max-count=1)

# Build the project
WORKDIR /root/.nexus/network-api/clients/cli
RUN cargo build --release

# Copy the script to container
WORKDIR /root/
COPY ./run.sh ./run.sh
RUN chmod +x run.sh

# Define command to run the application
CMD ["/root/run.sh"]
