---
description: React コンポーネントを規約に沿って生成
argument-hint: <ComponentName>
---

<!-- 🟡 半汎用: React系プロジェクトで使える -->

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

### 3. index.stories.tsx — Storybook ストーリー（条件付き）

- Only generate `index.stories.tsx` if Storybook is installed/configured in this repository.
  - If not sure, search for `.storybook/` directory or a `storybook` script in `package.json`.
  - If Storybook is not found, skip this step entirely.
- `@storybook/nextjs` フレームワークを使用
- Default、各バリアント、各状態（loading, error, empty）のストーリーを生成
- `satisfies Meta<typeof $ARGUMENTS>` で型安全に

### 4. index.ts — バレルエクスポート

```tsx
export { $ARGUMENTS } from "./index";
```

### 完了条件（すべて満たすまで完了としない）

- [ ] コンポーネントが正しくレンダリングされる
- [ ] `pnpm lint` がエラーなし
- [ ] `npx tsc --noEmit` がエラーなし
- [ ] `pnpm test -- --run src/components/$ARGUMENTS` で全テストパス
