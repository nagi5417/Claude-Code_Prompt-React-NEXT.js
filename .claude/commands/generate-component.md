---
description: React コンポーネントを規約に沿って生成
argument-hint: <ComponentName>
---

## コンポーネント: $ARGUMENTS

以下の規約に従い `src/components/$ARGUMENTS/` ディレクトリを作成し、必要なファイルを生成してください。

### 1. index.tsx — コンポーネント本体

- 関数コンポーネント + named export
- Props は interface で定義（`$ARGUMENTS` + `Props`）
- Server Component をデフォルトとし、useState/useEffect が必要な場合のみ `'use client'` を付与
- Tailwind CSS でスタイリング

```tsx
// テンプレート例
interface ${ARGUMENTS}Props {
  // props定義
}

export function $ARGUMENTS({ ...props }: ${ARGUMENTS}Props) {
  return (
    <div className="">
      {/* 実装 */}
    </div>
  );
}
```

### 2. index.test.tsx — ユニットテスト

- Vitest + React Testing Library を使用
- 基本レンダリング、Props 変更、ユーザーインタラクション、エッジケースをカバー

### 3. index.stories.tsx — Storybook ストーリー

- `@storybook/nextjs` フレームワークを使用
- Default、各バリアント、各状態（loading, error, empty）のストーリーを生成
- `satisfies Meta<typeof $ARGUMENTS>` で型安全に

### 4. index.ts — バレルエクスポート

```tsx
export { $ARGUMENTS } from "./index";
```

### 生成後の検証

- `pnpm lint` でリントチェック
- `pnpm test -- --run src/components/$ARGUMENTS` でテスト実行
