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
- `pnpm db:migrate`: Prisma マイグレーション実行（`npx prisma migrate dev`）
- `pnpm db:seed`: テストデータ投入
- `pnpm db:studio`: Prisma Studio 起動

## 絶対に守るべき制約

- Server Components をデフォルト使用。`'use client'` は useState/useEffect 使用時のみ付与
- App Router の動的パラメータ（params）は Promise であり、await が必要
- Server Component からデータ取得する場合は `fetch` で自分の API Route を呼ばず、Prisma を直接使用する
- Figma デザインからコード生成時は、`components/ui/` の既存コンポーネントと Tailwind トークンを優先して再利用すること
- .env ファイルは絶対にコミットしない
- `any` 型禁止。`unknown` を使用すること
- default export 禁止。named export のみ使用
- CSS は Tailwind ユーティリティクラスのみ。カスタム CSS ファイルは作成しない

## ゲート: 実装前に確認すること

以下が不明確な場合、コーディング前に必ず質問すること:

- API の入出力の形が未定義
- エラーハンドリングとステータスコードが未指定
- 認証・認可の要件が不明確
- データ整合性ルール（ユニーク制約、削除ポリシー）が不明確

## 完了の定義（最低条件）

UI 変更には以下を含めること:

- loading / empty / error 状態の実装
- 型チェック通過（`npx tsc --noEmit`）

API 変更には以下を含めること:

- 入力のバリデーション（Zod）
- 統一エラーレスポンス形式とステータスコード
- 最低2つの異常系の考慮（理想的にはテスト付き）

## 詳細ルール

- コードスタイル・命名規約 → `src/CLAUDE.md` を参照
- フロントエンド規約 → `.claude/rules/frontend.md` を参照
- バックエンド規約 → `.claude/rules/backend.md` を参照
- テスト規約 → `.claude/rules/testing.md` を参照
- 共通規約 → `.claude/rules/shared.md` を参照

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

## よくあるエラーと対処

### "Module not found" エラー

原因: パスエイリアス `@/` の解決失敗
対処: `tsconfig.json` の `paths` 設定を確認

### Prisma Client が見つからない

原因: `prisma generate` が未実行
対処: `npx prisma generate` を実行

### Hydration mismatch エラー

原因: Server Component と Client Component の境界で不整合
対処: `'use client'` の配置を確認。`Date` や `Math.random()` を Server Component で使っていないか確認

### "params is not iterable" エラー

原因: App Router の params を await せずに使用
対処: `const { id } = await params;` のように await する

<!-- 開発者コンテキスト（プロジェクトに合わせて記入してください）
## 開発者コンテキスト

- バックエンド経験あり（例: Java/Spring Boot）。フロントエンドは学習中
- 説明が必要な場合は、既知の技術の概念に例えて説明すること
- 複雑な実装をする場合は、なぜそうするのかの理由もコメントで残すこと
-->
