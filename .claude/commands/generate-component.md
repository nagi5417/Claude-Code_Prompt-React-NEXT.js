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

### 生成後の検証と修正ループ

1. `pnpm lint` でリントチェック → エラーがあれば修正
2. `pnpm test -- --run src/components/$ARGUMENTS` でテスト実行
3. テストが失敗した場合:
   - 失敗原因を分析
   - コンポーネントまたはテストを修正
   - 再度テスト実行
   - 全テスト通過するまで繰り返す（最大3回）
4. `npx tsc --noEmit` で型チェック → エラーがあれば修正
5. すべて通過したら完了を報告

### 成功時の期待出力

生成完了後、以下の状態になっていること:

- `src/components/$ARGUMENTS/index.tsx` が存在し、named export されている
- `src/components/$ARGUMENTS/index.test.tsx` が存在し、テストが通過している
- `src/components/$ARGUMENTS/index.ts` がバレルエクスポートとして存在
- Storybook がインストールされている場合のみ `index.stories.tsx` が存在
- `pnpm lint` がエラーなし
- `npx tsc --noEmit` がエラーなし
