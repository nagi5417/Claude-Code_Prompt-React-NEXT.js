# Next.js 15 フルスタックアプリテンプレート

Next.js 15 App Router + TypeScript strict + Prisma ORM + Tailwind CSS のモノリポ構成。

## コマンド

- `pnpm dev`: 開発サーバー起動（Turbopack、ポート3000）
- `pnpm build`: プロダクションビルド
- `pnpm test`: Vitest によるユニットテスト
- `pnpm test:e2e`: Playwright による E2E テスト
- `pnpm lint`: ESLint 実行
- `pnpm format`: Prettier 実行
- `pnpm db:migrate`: Prisma マイグレーション実行（`npx prisma migrate dev`）
- `pnpm db:seed`: テストデータ投入
- `pnpm db:studio`: Prisma Studio 起動

## コードスタイル

- TypeScript strict モード。`any` 型は禁止、`unknown` を使用
- default export ではなく named export を使用
- CSS は Tailwind ユーティリティクラスのみ。カスタム CSS ファイルは作成しない
- インポート順序: react → next → 外部ライブラリ → @/内部パス
- コンポーネントは関数コンポーネント + hooks のみ
- イベントハンドラは `handle` プレフィックス（handleClick, handleSubmit）
- コードスタイルは ESLint と Prettier で強制。リンターエラーが出たらその出力に従って修正すること

## アーキテクチャ

- `app/`: App Router のページとレイアウト
- `app/api/`: API ルートハンドラ（すべて `/api/v1` プレフィックス）
- `components/ui/`: 再利用可能な UI コンポーネント（shadcn/ui ベース）
- `components/`: 機能別コンポーネント
- `hooks/`: カスタム React hooks
- `lib/`: ユーティリティ、API クライアント、共有ロジック
- `prisma/`: データベーススキーマとマイグレーション
- `tests/`: テストファイル

## 注意事項

- IMPORTANT: Server Components をデフォルトで使用。`'use client'` は必要な場合のみ付与
- IMPORTANT: App Router の動的パラメータ（params）は Promise であり、await が必要
- .env ファイルは絶対にコミットしない
- DB スキーマの詳細は @prisma/schema.prisma を参照
