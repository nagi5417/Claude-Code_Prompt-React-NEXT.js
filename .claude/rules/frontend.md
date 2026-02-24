---
paths:
  - "src/components/**/*.tsx"
  - "src/components/**/*.ts"
  - "app/**/*.tsx"
  - "hooks/**/*.ts"
---

# フロントエンド開発規約

## コンポーネント

- Server Components をデフォルト。useState/useEffect が必要な場合のみ `'use client'`
- Props は interface で定義（`ComponentNameProps`）
- named export のみ（default export 禁止）
- 1コンポーネント200行以内。超える場合は分割
- children を受け取るコンポーネントは `React.PropsWithChildren` を使用

## スタイリング

- Tailwind CSS ユーティリティクラスのみ
- バリアント管理には class-variance-authority (cva)
- cn() ヘルパー（clsx + tailwind-merge）でクラス名マージ

## パフォーマンス

- dynamic import: 重いコンポーネントには `next/dynamic` + `ssr: false`
- Image: `next/image` 必須、width/height または fill を指定
- Link: `next/link` 必須、外部リンクのみ `<a>` タグ

## フォーム

- Server Actions + useActionState パターン推奨
- バリデーション: Zod スキーマをクライアント・サーバーで共有
