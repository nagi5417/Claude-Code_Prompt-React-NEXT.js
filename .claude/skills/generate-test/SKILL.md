---
name: generate-test
description: "Vitest + React Testing Library でユニットテストを生成する。ユーザーが「テストを書いて」「テストを追加して」「テストを作って」「カバレッジを上げて」と言ったときに使用する。E2Eテストには使わない（generate-e2e を使用）。"
argument-hint: <file-path>
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(pnpm test:*), Bash(npx tsc:*)
model: sonnet
---

# テスト生成: $ARGUMENTS

対象ファイル `$ARGUMENTS` を読み込み、ユニットテストを生成する。

## 生成ルール

- テストファイルは対象ファイルと同階層に `*.test.ts(x)` として配置
- カバレッジパターンは `references/test-coverage-patterns.md` を参照

## 制約

- Vitest (`describe`, `it`, `expect`) + React Testing Library (`render`, `screen`, `userEvent`)
- AAA パターン（Arrange, Act, Assert）
- 外部依存は `vi.mock()` でモック
- API コールは msw でモック
- クエリ優先度: `getByRole` > `getByLabelText` > `getByText` > `getByTestId`
- 各テストは独立（テスト間で状態共有しない）

## 検証ワークフロー

以下を順番に実行し、エラーがあれば修正して再実行する（最大3回）:

1. `pnpm test -- --run $ARGUMENTS` → テスト実行
2. `npx tsc --noEmit` → 型チェック

## 完了条件

- テストファイルが対象ファイルと同階層に存在
- 正常系・異常系・エッジケースがカバーされている
- `pnpm test -- --run` で全テスト通過
- `npx tsc --noEmit` がエラーなし