---
paths:
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.spec.ts"
  - "tests/**/*"
---

# テスト規約

## ユニットテスト（Vitest + React Testing Library）

- テストファイルは対象ファイルと同階層に `*.test.ts(x)`
- AAA パターン（Arrange, Act, Assert）
- クエリ優先度: getByRole > getByLabelText > getByText > getByTestId
- 外部依存は vi.mock() でモック、API は msw でモック
- 各テストは独立（テスト間で状態共有しない）

## E2E テスト（Playwright）

- `tests/e2e/` ディレクトリに配置
- Page Object Model パターン
- テストデータは fixtures で管理
- CI で headless 実行、ローカルでは UI モード使用可

## カバレッジ

- 全体: 80% 以上
- クリティカルパス: 95% 以上
