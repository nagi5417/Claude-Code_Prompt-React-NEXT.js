---
description: Playwright で E2E テストを生成
argument-hint: <feature-name> (例: auth-flow, checkout)
---

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

### 生成後

- `pnpm test:e2e -- --grep "$ARGUMENTS"` で実行確認
