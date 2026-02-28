---
description: コンポーネントの Storybook ストーリーを生成
argument-hint: <component-path>
---

<!-- 🟡 半汎用: React系プロジェクトで使える -->

## Storybook: $ARGUMENTS

@$ARGUMENTS のコンポーネントを読み込み、Storybook ストーリーを生成してください。

### テンプレート

```typescript
import type { Meta, StoryObj } from "@storybook/nextjs";
import { ComponentName } from "./ComponentName";

const meta = {
  title: "Category/ComponentName",
  component: ComponentName,
  parameters: { layout: "centered" },
  tags: ["autodocs"],
  argTypes: {
    // Props から自動生成
  },
} satisfies Meta<typeof ComponentName>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = { args: {} };
export const WithVariant: Story = { args: { variant: "secondary" } };
export const Loading: Story = { args: { isLoading: true } };
export const Error: Story = { args: { error: "エラーが発生しました" } };
export const Empty: Story = { args: { data: [] } };
```

### カテゴリ自動判定

- `components/ui/*` → `UI/ComponentName`
- `components/*` → `Components/ComponentName`
- `app/**` → `Pages/RouteName`

### 生成後

- `pnpm storybook` で表示確認
