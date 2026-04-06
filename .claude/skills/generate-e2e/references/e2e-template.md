# E2E テストテンプレート

## spec ファイル

```typescript
import { test, expect } from "@playwright/test";

test.describe("${featureName}", () => {
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

## Page Object パターン

```typescript
// tests/e2e/pages/${featureName}.page.ts
import { type Page, type Locator } from "@playwright/test";

export class ${FeatureName}Page {
  readonly page: Page;
  readonly submitButton: Locator;

  constructor(page: Page) {
    this.page = page;
    this.submitButton = page.getByRole("button", { name: "送信" });
  }

  async navigate() {
    await this.page.goto("/${feature-path}");
  }

  async submit() {
    await this.submitButton.click();
  }
}
```