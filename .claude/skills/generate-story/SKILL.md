---
name: generate-story
description: "コンポーネントの Storybook ストーリーを生成する。ユーザーが「ストーリーを作って」「Storybookを追加して」「コンポーネントカタログ」と言ったときに使用する。コンポーネント本体の実装には使わない（generate-component を使用）。"
argument-hint: <component-path>
allowed-tools: Read, Write, Edit, Glob, Grep
model: sonnet
---

# Storybook ストーリー生成: $ARGUMENTS

対象コンポーネント `$ARGUMENTS` を読み込み、Storybook ストーリーを生成する。

## テンプレート

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

## カテゴリ判定

- `components/ui/*` → `UI/ComponentName`
- `components/*` → `Components/ComponentName`
- `app/**` → `Pages/RouteName`

## 完了条件

- ストーリーファイルが対象コンポーネントと同階層に存在
- Default、各バリアント、各状態のストーリーが含まれている
- `satisfies Meta<typeof Component>` で型安全に定義されている