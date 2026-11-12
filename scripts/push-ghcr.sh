#!/bin/bash
# Script đẩy image lên GHCR (Bước 4)
# Chạy trong GitHub Codespaces

set -e

GITHUB_USER="dinhtanminh2324802010289"  # Thay bằng tên GitHub viết thường

echo "============================================"
echo "  BƯỚC 4 – ĐẨY IMAGE LÊN GHCR"
echo "============================================"

echo ""
echo ">>> Đăng nhập vào GHCR..."
echo $CR_PAT | docker login ghcr.io -u $GITHUB_USER --password-stdin

echo ""
echo ">>> Tag image..."
docker tag notes-api:1.0 ghcr.io/$GITHUB_USER/notes-api:1.0

echo ""
echo ">>> Push image lên GHCR..."
docker push ghcr.io/$GITHUB_USER/notes-api:1.0

echo ""
echo ">>> Xóa container và image cục bộ..."
docker rm -f notes1 notes2
docker rmi ghcr.io/$GITHUB_USER/notes-api:1.0 notes-api:1.0

echo ""
echo ">>> Kéo image từ GHCR và chạy..."
docker run -d -p 3000:3000 ghcr.io/$GITHUB_USER/notes-api:1.0

sleep 3
echo ""
echo ">>> Kiểm tra:"
curl -s localhost:3000 && echo

echo ""
echo "============================================"
echo "  BƯỚC 4 HOÀN TẤT"
echo "============================================"
echo ">>> Nhớ vào GitHub → Packages → notes-api → Package settings → Change visibility → Public"

