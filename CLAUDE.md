# Next.js 15 フルスタックアプリテンプレート

> 応答言語: 日本語

Next.js 15 App Router + TypeScript strict + Prisma ORM + Tailwind CSS のモノリポ構成。

## コマンド

- `pnpm dev`: 開発サーバー起動（Turbopack、ポート3000）
- `pnpm build`: プロダクションビルド
- `pnpm test`: Vitest ユニットテスト
- `pnpm test:e2e`: Playwright E2E テスト
- `pnpm lint`: ESLint 実行
- `pnpm format`: Prettier 実行
- `pnpm db:migrate`: Prisma マイグレーション実行
- `pnpm db:seed`: テストデータ投入
- `pnpm db:studio`: Prisma Studio 起動

## 絶対に守るべき制約

- `any` 型禁止。`unknown` を使用すること
- default export 禁止。named export のみ使用
- .env ファイルは絶対にコミットしない
- Server Components をデフォルト使用。`'use client'` は useState/useEffect 使用時のみ
- App Router の params は Promise なので `await` が必要
- Server Component から `fetch` で自分の API Route を呼ばず、Prisma を直接使用する

## 詳細ルール（参照先）

- コードスタイル・命名規約 → `src/CLAUDE.md`
- フロントエンド規約 → `.claude/rules/frontend.md`
- バックエンド規約 → `.claude/rules/backend.md`
- テスト規約 → `.claude/rules/testing.md`
- 共通規約 → `.claude/rules/shared.md`

## アーキテクチャ

- `app/`: App Router のページとレイアウト
- `app/api/`: API ルートハンドラ（すべて `/api/v1` プレフィックス）
- `components/ui/`: 再利用可能な UI コンポーネント（shadcn/ui ベース）
- `components/`: 機能別コンポーネント
- `hooks/`: カスタム React hooks
- `lib/`: ユーティリティ、API クライアント、共有ロジック
- `prisma/`: データベーススキーマとマイグレーション
- `tests/`: テストファイル
- `tasks/`: タスク管理と学びの記録（todo.md, lessons.md）

DB スキーマの詳細は `prisma/schema.prisma` を参照。