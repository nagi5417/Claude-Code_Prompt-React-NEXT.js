---
description: Playwright で E2E テストを生成
argument-hint: <feature-name> (例: auth-flow, checkout)
---

<!-- 🟡 半汎用: テストツール名を変更すれば使える -->

## E2E テスト: $ARGUMENTS

`tests/e2e/$ARGUMENTS.spec.ts` に Playwright E2E テストを生成してください。

### 規約

- Page Object Model パターンを使用
- `tests/e2e/pages/` にページオブジェクトを配置
- テストデータは `tests/e2e/fixtures/` に配置
- スクリーンショットは失敗時のみキャプチャ

### テンプレート

```typescript
import { test, expect } from "@playwright/test";

test.describe("$ARGUMENTS", () => {
  test.beforeEach(async ({ page }) => {
    await page.goto("/");
  });

  test("主要なユーザーフローが正常に動作する", async ({ page }) => {
    // Arrange
    // Act
    // Assert
    await expect(page).toHaveURL(/expected-url/);
  });

  test("エラー時に適切なフィードバックを表示する", async ({ page }) => {
    // エラーシナリオ
  });

  test("モバイルビューポートで正しく動作する", async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });
    // モバイル特有のテスト
  });
});
```

### 生成後の検証と修正ループ

1. `pnpm test:e2e -- --grep "$ARGUMENTS"` で実行確認
2. テストが失敗した場合:
   - 失敗原因を分析（セレクタ不一致、タイミング問題、テストデータ不足など）
   - テストコードまたは Page Object を修正
   - 再度テスト実行
   - 全テスト通過するまで繰り返す（最大3回）
3. すべて通過したら完了を報告

### 成功時の期待出力

- `tests/e2e/$ARGUMENTS.spec.ts` が存在
- Page Object が `tests/e2e/pages/` に配置されている（必要な場合）
- テストデータが `tests/e2e/fixtures/` に配置されている（必要な場合）
- 主要ユーザーフロー、エラーシナリオ、モバイルビューポートのテストが含まれている
- `pnpm test:e2e -- --grep "$ARGUMENTS"` で全テスト通過
