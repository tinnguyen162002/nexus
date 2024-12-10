#!/bin/bash
NEXUS_HOME=$HOME/.nexus
mkdir -p $NEXUS_HOME

# Kiểm tra xem PROVER_ID có được đặt hay không
if [ -z "$PROVER_ID" ]; then
    echo "Error: PROVER_ID is not set. Exiting."
    exit 1
fi

# Lưu PROVER_ID vào file
echo "$PROVER_ID" > $NEXUS_HOME/prover-id
echo "PROVER_ID saved to $NEXUS_HOME/prover-id."

# Chạy chương trình
cd $NEXUS_HOME/network-api/clients/cli
cargo run --release --bin prover -- beta.orchestrator.nexus.xyz
