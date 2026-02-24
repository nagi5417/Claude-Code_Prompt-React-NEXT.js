# tests/ — テストポリシー

- テストファイル名は `*.test.ts` または `*.test.tsx`
- 外部 API は msw でモック
- React コンポーネントテストは @testing-library/react を使用
- カバレッジ 80% 以上を目標

## ディレクトリ構成

- `tests/e2e/` — Playwright E2E テスト（`*.spec.ts`）
- `tests/e2e/pages/` — Page Object Model
- `tests/e2e/fixtures/` — テストデータ
- `tests/setup.ts` — Vitest グローバルセットアップ

## 命名規約

- ユニットテスト: `{対象ファイル名}.test.ts(x)` — 対象ファイルと同階層に配置
- E2E テスト: `tests/e2e/{feature-name}.spec.ts`
- テストデータ: `tests/e2e/fixtures/{feature-name}.json`
