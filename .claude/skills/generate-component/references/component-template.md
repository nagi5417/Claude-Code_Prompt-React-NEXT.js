# コンポーネントテンプレート

## index.tsx
```tsx
interface ${ComponentName}Props {
  // props定義
}

export function ${ComponentName}({ ...props }: ${ComponentName}Props) {
  return (
    <div className="">
      {/* 実装 */}
    </div>
  );
}
```

## 規約

- `children` を受け取る場合は `React.PropsWithChildren` を使用
- バリアント管理には class-variance-authority (cva) を使用
- クラス名のマージには `cn()` ヘルパー（clsx + tailwind-merge）を使用
- イベントハンドラは `handle` プレフィックス（handleClick, handleSubmit）

## index.ts（バレルエクスポート）
```tsx
export { ${ComponentName} } from "./index";
```