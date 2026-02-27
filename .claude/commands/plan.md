---
description: 調査結果に基づく実装計画を策定
argument-hint: <task-description>
---

<!-- 🔵 汎用: どのプロジェクトでも使える -->

# 実装計画フェーズ

## 入力: $ARGUMENTS

## 手順

1. 関連する調査ドキュメント（`docs/investigate/`）があれば読み込む
2. 実装スコープを定義（何を含み、何を含まないか）
3. タスクを分解し、依存関係を整理
4. 各タスクの実装順序を決定
5. リスクと対策を明記

## Output filename rule

- Save output to: `docs/plan/YYYYMMDD_HHMM_<slug>.md`
- slug is derived from $ARGUMENTS:
  - lowercase
  - spaces → `-`
  - remove or replace `/ \ : * ? " < > |` with `-`
  - trim repeated `-`
- Example: `docs/plan/20260226_2301_auth-login.md`

## 出力

上記ルールに従ったファイルに以下を記録:

### 実装計画

- 目的と背景
- スコープ（In Scope / Out of Scope）
- 変更対象ファイル一覧

### タスク分解

| #   | タスク | 対象ファイル | 依存 | 見積 |
| --- | ------ | ------------ | ---- | ---- |
| 1   | ...    | ...          | -    | ...  |

### 技術的決定事項

- 選択したアプローチと理由
- 代替案と却下理由

### リスクと対策

- 既知のリスクと緩和策

### 検証計画

- テスト方針
- 動作確認手順

status: COMPLETED
next: IMPLEMENT
