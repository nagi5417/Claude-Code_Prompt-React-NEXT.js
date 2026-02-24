#!/usr/bin/env bash
# format-and-lint.sh — Prettier + ESLint 実行スクリプト（参考用）
#
# メインの自動化は .claude/settings.json の hooks (PostToolUse) で実施。
# このスクリプトは手動実行や CI での利用を想定した参考実装。

set -euo pipefail

# 引数でファイルパスを受け取る（省略時はステージングされたファイルを対象）
if [ $# -gt 0 ]; then
  FILES=("$@")
else
  mapfile -t FILES < <(git diff --cached --name-only --diff-filter=ACMR | grep -E '\.(ts|tsx|js|jsx|json|css|md)$' || true)
fi

if [ ${#FILES[@]} -eq 0 ]; then
  echo "対象ファイルがありません"
  exit 0
fi

echo "=== Prettier ==="
npx prettier --write "${FILES[@]}" 2>/dev/null || echo "Prettier: 一部ファイルでエラー"

# TypeScript/JavaScript ファイルのみ ESLint を実行
TS_FILES=()
for f in "${FILES[@]}"; do
  if [[ "$f" =~ \.(ts|tsx|js|jsx)$ ]]; then
    TS_FILES+=("$f")
  fi
done

if [ ${#TS_FILES[@]} -gt 0 ]; then
  echo "=== ESLint ==="
  npx eslint --fix "${TS_FILES[@]}" 2>/dev/null || echo "ESLint: 一部ファイルでエラー"
fi

echo "=== 完了 ==="
