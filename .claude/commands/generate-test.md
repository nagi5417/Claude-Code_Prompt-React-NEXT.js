---
description: Vitest + React Testing Library でユニットテストを生成
argument-hint: <file-path>
allowed-tools: Read, Grep, Glob, Bash(pnpm test:*)
---

<!-- 🟡 半汎用: テストツール名を変更すれば使える -->

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

### 生成後の検証と修正ループ

1. `pnpm test -- --run $ARGUMENTS` でテスト実行
2. テストが失敗した場合:
   - 失敗原因を分析（モックの不足、非同期処理の待ち不足、セレクタの不一致など）
   - テストコードを修正
   - 再度テスト実行
   - 全テスト通過するまで繰り返す（最大3回）
3. `npx tsc --noEmit` で型チェック → エラーがあれば修正
4. すべて通過したら完了を報告

### 成功時の期待出力

- テストファイルが対象ファイルと同階層に `*.test.ts(x)` として存在
- 正常系・異常系・エッジケースのテストが含まれている
- `pnpm test -- --run` で全テスト通過
- `npx tsc --noEmit` がエラーなし
