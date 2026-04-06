---
name: generate-e2e
description: "Playwright で E2E テストを生成する。ユーザーが「E2Eテストを作って」「エンドツーエンドテスト」「Playwrightテスト」「ユーザーフローのテスト」と言ったときに使用する。ユニットテストには使わない（generate-test を使用）。"
argument-hint: <feature-name> (例: auth-flow, checkout)
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(pnpm test:e2e:*), Bash(npx playwright:*)
model: sonnet
---

# E2E テスト生成: $ARGUMENTS

`tests/e2e/$ARGUMENTS.spec.ts` に Playwright E2E テストを生成する。

## 生成ルール

- Page Object Model パターンを使用
- Page Object は `tests/e2e/pages/` に配置
- テストデータは `tests/e2e/fixtures/` に配置
- テンプレートは `references/e2e-template.md` を参照

## 制約

- スクリーンショットは失敗時のみキャプチャ
- テストデータの独立性（テスト間で状態共有しない）
- CI 環境での並列実行を考慮

## テストシナリオ（必須）

1. 主要なユーザーフローが正常に動作する
2. エラー時に適切なフィードバックを表示する
3. モバイルビューポートで正しく動作する

## 検証ワークフロー

以下を順番に実行し、エラーがあれば修正して再実行する（最大3回）:

1. `pnpm test:e2e -- --grep "$ARGUMENTS"` → テスト実行

## 完了条件

- `tests/e2e/$ARGUMENTS.spec.ts` が存在
- Page Object が配置されている（必要な場合）
- 全テストシナリオが通過