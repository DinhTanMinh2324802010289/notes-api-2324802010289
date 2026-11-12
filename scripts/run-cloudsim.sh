#!/bin/bash
# Script chạy CloudSim Plus BasicFirstExample
# Sử dụng trong GitHub Codespaces (đã cài JDK 25)

set -e

EXAMPLE_DIR="/tmp/cloudsimplus-examples"

# Clone nếu chưa có
if [ ! -d "$EXAMPLE_DIR" ]; then
  echo ">>> Cloning CloudSim Plus examples..."
  cd /tmp
  git clone https://github.com/cloudsimplus/cloudsimplus-examples.git
fi

cd "$EXAMPLE_DIR"

# Chạy ví dụ
echo ""
echo "============================================"
echo "  Chạy: $1"
echo "============================================"
echo ""

sh bootstrap.sh "$1"

