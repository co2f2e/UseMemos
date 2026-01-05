#!/usr/bin/env bash
set -e

SERVICE_NAME="memos"
BIN_PATH="/usr/local/bin/memos"
DATA_DIR="/var/lib/memos"

echo "🧹 开始卸载 UseMemos"

if systemctl list-unit-files | grep -q "^${SERVICE_NAME}.service"; then
  echo "🛑 停止 systemd 服务..."
  sudo systemctl stop $SERVICE_NAME
  sudo systemctl disable $SERVICE_NAME
  sudo rm -f /etc/systemd/system/$SERVICE_NAME.service
  sudo systemctl daemon-reload
  echo "✅ systemd 服务已移除"
else
  echo "ℹ️ 未检测到 systemd 服务，跳过"
fi

if [ -f "$BIN_PATH" ]; then
  echo "🗑 删除二进制文件: $BIN_PATH"
  sudo rm -f "$BIN_PATH"
else
  echo "ℹ️ 未找到 memos 二进制文件"
fi

echo
read -p "⚠️ 是否删除数据目录 $DATA_DIR（包含 SQLite 数据）？(y/N): " yn
if [[ "$yn" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  if [ -d "$DATA_DIR" ]; then
    echo "🔥 正在删除数据目录..."
    sudo rm -rf "$DATA_DIR"
    echo "✅ 数据目录已删除"
  else
    echo "ℹ️ 数据目录不存在"
  fi
else
  echo "📦 已保留数据目录: $DATA_DIR"
fi

echo
echo "🎉 UseMemos 卸载完成"
