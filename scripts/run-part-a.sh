#!/bin/bash
# Script thực hiện toàn bộ Phần A - Container
# Chạy trong GitHub Codespaces

set -e

GITHUB_USER="dinhtanminh2324802010289"  # Thay bằng tên GitHub viết thường

echo "============================================"
echo "  PHẦN A – CONTAINER"
echo "============================================"

echo ""
echo ">>> Bước 1: Build Docker image..."
docker build -t notes-api:1.0 .
echo ""
echo ">>> Docker images:"
docker images notes-api

echo ""
echo ">>> Bước 2: Chạy hai bản sao..."

# Xóa container cũ nếu có
docker rm -f notes1 notes2 2>/dev/null || true

docker run -d --name notes1 -p 3000:3000 notes-api:1.0
docker run -d --name notes2 -p 3001:3000 --cpus=0.5 --memory=128m notes-api:1.0

echo ""
echo ">>> Đợi container khởi động..."
sleep 3

echo ""
echo ">>> Kết quả từ notes1 (port 3000):"
curl -s localhost:3000 && echo

echo ""
echo ">>> Kết quả từ notes2 (port 3001):"
curl -s localhost:3001 && echo

echo ""
echo ">>> Docker stats:"
docker stats --no-stream

echo ""
echo ">>> Bước 3: So sánh với máy ảo..."
echo ">>> Thời gian khởi động container:"
time docker run --rm notes-api:1.0 node -e "1"

echo ""
echo ">>> Kích thước image:"
docker images notes-api --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

echo ""
echo ">>> Kernel bên ngoài container:"
uname -r

echo ""
echo ">>> Kernel bên trong container notes1:"
docker exec notes1 uname -r

echo ""
echo "============================================"
echo "  PHẦN A HOÀN TẤT"
echo "============================================"

