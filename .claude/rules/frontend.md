---
paths:
  - "src/components/**/*.tsx"
  - "src/components/**/*.ts"
  - "app/**/*.tsx"
  - "hooks/**/*.ts"
---

<!-- 🟡 半汎用: React系プロジェクトで使える -->

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

## デザイン連携（Figma）

- UI 実装依頼時はまずデザインプロンプトを作成し、Figma Make での生成を提案する
- Figma の `get_design_context` が返す参照コードはそのまま使わず、プロジェクトの規約に適応する
- スタイル値は Tailwind ユーティリティクラスにマッピング。カスタム CSS は作成しない
- Figma のレイヤー名をコンポーネント名・Props 名の参考にする
- レスポンシブデザインを優先。Figma の固定サイズをそのままハードコードしない
- shadcn/ui に同等コンポーネントがあればそちらを使用する
