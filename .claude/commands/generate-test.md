---
description: Vitest + React Testing Library でユニットテストを生成
argument-hint: <file-path>
allowed-tools: Read, Grep, Glob, Bash(pnpm test:*)
---

## テスト対象: $ARGUMENTS

対象ファイル @$ARGUMENTS を読み込み、包括的なユニットテストを生成してください。

### テスト規約

- Vitest (`describe`, `it`, `expect`) + React Testing Library (`render`, `screen`, `userEvent`)
- テストファイルは対象ファイルと同階層に `*.test.ts(x)` として配置
- 外部依存は `vi.mock()` でモック
- API コールは msw でモック
- AAA パターン（Arrange, Act, Assert）で記述

### テストカバレッジ要件

1. **正常系**: 主要な入出力パターンをすべてカバー
2. **異常系**: null, undefined, 空配列, 空文字列, 境界値
3. **コンポーネントの場合**:
   - レンダリング確認
   - Props による表示切り替え
   - ユーザーインタラクション（click, input, submit）
   - ローディング状態 / エラー状態
   - アクセシビリティ（`getByRole` 優先）
4. **API Route の場合**:
   - 各 HTTP メソッドの正常レスポンス
   - バリデーションエラー（400）
   - 認証エラー（401）/ 権限エラー（403）
   - 存在しないリソース（404）
   - サーバーエラー（500）

### 生成後

- `pnpm test -- --run $ARGUMENTS` でテスト実行
- 失敗するテストがあれば修正
