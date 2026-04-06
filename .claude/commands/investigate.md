---
description: 要件を調査し、実装方針を文書化
argument-hint: <task-description>
---

<!-- 🔵 汎用: どのプロジェクトでも使える -->

# 調査フェーズ

## 入力: $ARGUMENTS

## 手順

1. 要件・スコープを明確化
2. 関連ファイル・ドキュメントを体系的に収集・分析
3. 技術的制約と選択肢を調査
4. 既存システムとの整合性を確認
5. 実装方針を策定

## Output filename rule

- Save output to: `docs/investigate/YYYYMMDD_HHMM_<slug>.md`
- slug is derived from $ARGUMENTS:
  - lowercase
  - spaces → `-`
  - remove or replace `/ \ : * ? " < > |` with `-`
  - trim repeated `-`
- Example: `docs/investigate/20260226_2302_why-build-fails.md`

## 出力

上記ルールに従ったファイルに以下を記録:

- 背景と要件
- 関連ファイル一覧
- 技術的選択肢の比較
- 推奨方針と理由
- リスクと対策
- 次フェーズ（Plan/Implement）への推奨事項

status: COMPLETED
next: PLAN
