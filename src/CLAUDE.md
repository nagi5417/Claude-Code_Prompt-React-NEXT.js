# src/ — ソースコード配下のコンテキスト

## ディレクトリ構成

- `app/` — App Router のページ、レイアウト、API Routes
- `components/` — React コンポーネント（機能別サブディレクトリ）
- `components/ui/` — shadcn/ui ベースの汎用 UI コンポーネント
- `hooks/` — カスタム React hooks
- `lib/` — ユーティリティ関数、API クライアント、DB クライアント、共有ロジック
- `types/` — 共有型定義

## 命名規約

- コンポーネント: PascalCase（`UserProfile.tsx`）
- hooks: camelCase + `use` プレフィックス（`useAuth.ts`）
- ユーティリティ: camelCase（`formatDate.ts`）
- 型定義: PascalCase（`User.ts`）
- API Route: `route.ts`（Next.js 規約）

## インポートルール

- パスエイリアス `@/` を使用（`@/components/...`, `@/lib/...`）
- 相対パスは同一ディレクトリ内のみ許可
- バレルエクスポート（`index.ts`）を活用してインポートを簡潔に
- 順序: react → next → 外部ライブラリ → @/ 内部パス → ./ 相対パス
