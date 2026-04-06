# テスト・Storybook テンプレート

## index.test.tsx

Vitest + React Testing Library を使用。
```tsx
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, it, expect } from "vitest";
import { ${ComponentName} } from "./index";

describe("${ComponentName}", () => {
  it("正常にレンダリングされる", () => {
    render(<${ComponentName} />);
    // getByRole > getByLabelText > getByText の優先順位
  });

  it("Props に応じて表示が切り替わる", () => {
    // Arrange
    // Act
    // Assert
  });

  it("ユーザー操作に正しく反応する", async () => {
    const user = userEvent.setup();
    render(<${ComponentName} />);
    // await user.click(...)
  });

  it("エッジケースを処理する", () => {
    // null, undefined, 空配列, 空文字列
  });
});
```

### テスト規約

- AAA パターン（Arrange, Act, Assert）
- 外部依存は `vi.mock()` でモック
- API コールは msw でモック
- 各テストは独立（テスト間で状態共有しない）

## index.stories.tsx

Storybook がインストールされている場合のみ生成する。
```tsx
import type { Meta, StoryObj } from "@storybook/nextjs";
import { ${ComponentName} } from "./${ComponentName}";

const meta = {
  title: "Components/${ComponentName}",
  component: ${ComponentName},
  parameters: { layout: "centered" },
  tags: ["autodocs"],
} satisfies Meta<typeof ${ComponentName}>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = { args: {} };
export const Loading: Story = { args: { isLoading: true } };
export const Error: Story = { args: { error: "エラーが発生しました" } };
export const Empty: Story = { args: { data: [] } };
```

### カテゴリ判定

- `components/ui/*` → `title: "UI/${ComponentName}"`
- `components/*` → `title: "Components/${ComponentName}"`
- `app/**` → `title: "Pages/${RouteName}"`