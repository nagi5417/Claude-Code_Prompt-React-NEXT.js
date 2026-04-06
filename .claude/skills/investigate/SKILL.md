---
name: investigate
description: "要件を調査し、実装方針を文書化する。ユーザーが「調査して」「調べて」「検討して」「実装方針を考えて」「技術選定して」と言ったときに使用する。実装やコーディングには使わない。"
argument-hint: <task-description>
allowed-tools: Read, Glob, Grep, Bash(find:*), Bash(wc:*)
model: sonnet
context: fork
---

# 調査: $ARGUMENTS

## ワークフロー

1. 要件・スコープを明確化する
2. 関連ファイル・ドキュメントを体系的に収集・分析する
3. 技術的制約と選択肢を調査する
4. 既存システムとの整合性を確認する
5. 実装方針を策定する

## 出力

以下を `docs/investigate/YYYYMMDD_HHMM_<slug>.md` に記録する:

- 背景と要件
- 関連ファイル一覧
- 技術的選択肢の比較
- 推奨方針と理由
- リスクと対策
- 次フェーズ（Plan/Implement）への推奨事項

slug は $ARGUMENTS を lowercase + スペースを `-` に変換して生成する。

## 完了条件

- 調査ドキュメントが `docs/investigate/` に保存されている
- 技術的選択肢が比較・評価されている
- 推奨方針とリスクが明記されている