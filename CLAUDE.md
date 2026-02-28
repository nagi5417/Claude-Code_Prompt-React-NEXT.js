# Next.js 15 フルスタックアプリテンプレート

> 応答言語: 日本語

Next.js 15 App Router + TypeScript strict + Prisma ORM + Tailwind CSS のモノリポ構成。

## 技術スタック（バージョン）

- Next.js: 15.x (App Router)
- React: 19.x
- TypeScript: 5.x (strict)
- Prisma: 6.x
- Node.js: 20.x
- pnpm: 9.x

> プロジェクトごとに実際のバージョンに合わせて更新すること

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
- `tasks/`: タスク管理と学びの記録（todo.md, lessons.md）

## ワークフロー

### Planモードを基本とする

- 3ステップ以上またはアーキテクチャに関わるタスクは、必ず計画を先に提示し、承認を得てから実装に入ること
- 途中でうまくいかなくなったら、無理に進めず立ち止まって再計画すること
- 構築だけでなく、検証ステップにも計画を立てること
- 曖昧さを減らすため、実装前に詳細な仕様を書くこと

### サブエージェント運用

- メインのコンテキストウィンドウをクリーンに保つため、調査・分析・検証はサブエージェントに委任する
- 1サブエージェントにつき1タスクを厳守する（万能エージェントは作らない）
- サブエージェントの結果は要約だけメインに返す
- 複雑な問題には、複数のサブエージェントを並列で投入する

### 自律的なバグ修正

- バグレポートやエラーログを受け取ったら、確認質問なしに自律的に修正すること
- ログ・エラーメッセージ・失敗テストを自分で読み、根本原因を特定して修正する
- CIが失敗していたら、指示されなくても修正に動くこと
- ユーザーのコンテキスト切り替えをゼロにすることを目指す

### 自己改善ループ

- ユーザーから修正指示を受けたら、必ず `tasks/lessons.md` にミスのパターンと対策を記録すること
- セッション開始時に `tasks/lessons.md` を確認し、同じミスを繰り返さないこと
- ミス率が下がるまで、ルールを徹底的に改善し続けること
- lessons.md にはプロジェクト固有の学びのみ記録する（一般論は書かない）

### タスク管理

1. まず計画を立てる：`tasks/todo.md` にチェックリスト形式で計画を書く
2. 実装前に計画をユーザーに確認してもらう
3. 完了した項目を随時チェックしていく
4. 各ステップで変更の高レベルサマリーを記録する
5. 完了後に `tasks/todo.md` にレビューセクションを追加する
6. 修正を受けたら `tasks/lessons.md` を更新する

## 注意事項

- IMPORTANT: Server Components をデフォルトで使用。`'use client'` は必要な場合のみ付与
- IMPORTANT: App Router の動的パラメータ（params）は Promise であり、await が必要
- IMPORTANT: Server Component からデータを取得する場合は `fetch` で自分の API Route を呼ばず、Prisma を直接使用する。`fetch` 経由だとポート番号の問題が発生する
- .env ファイルは絶対にコミットしない
- DB スキーマの詳細は @prisma/schema.prisma を参照

## Claude への指示

- 日本語で応答すること
- 実装前に必ず既存コードを読んで、プロジェクトのパターンに合わせること
- 不明点があればコードを書く前に質問すること（shared.md の Gate ルール参照）
- 1つのタスクで変更するファイルは最小限にすること
- テストが通らない状態でタスクを完了としないこと
- 新しいライブラリを追加する前に既存の依存で対応できないか検討すること
- エラーが発生した場合、最大3回まで自力で修正を試み、解決しなければユーザーに報告すること

## エージェント使用ガイド

### いつエージェントを使うか

- コードレビューを依頼したい → `code-reviewer`（opus で高精度）
- テストだけを集中的に書きたい → `test-engineer`
- リリース前の監査 → `security-auditor` / `performance-auditor` / `accessibility-auditor`

### エージェントを使わなくてよい場合

- 通常のコンポーネント作成 → `/generate-component` コマンドで十分
- API ルート作成 → `/generate-api-route` コマンドで十分
- 小規模な修正・機能追加 → Claude Code 本体に直接依頼

## コマンド使用頻度

### 日常的に使う

- `/commit` — コミットのたびに使用
- `/review` — PR 前のレビュー
- `/create-pr` — PR 作成
- `/generate-component` — 新規コンポーネント作成
- `/generate-test` — テスト作成

### 状況に応じて使う

- `/investigate`, `/plan` — 大きめの機能開発時
- `/refactor` — コード整理時

### 必要なときだけ使う

- `/generate-api-route`, `/generate-migration`, `/generate-types` — 新規エンティティ追加時
- `/generate-e2e`, `/generate-story` — 必要に応じて

## ドキュメント役割

- `CLAUDE.md` → Claude Code が読む指示書（簡潔に保つ）
- `docs/claude-usage.md` → 人間が読む運用ガイド（詳細な説明）

<!-- 開発者コンテキスト（プロジェクトに合わせて記入してください）
## 開発者コンテキスト

- バックエンド経験あり（例: Java/Spring Boot）。フロントエンドは学習中
- 説明が必要な場合は、既知の技術の概念に例えて説明すること
- 複雑な実装をする場合は、なぜそうするのかの理由もコメントで残すこと
-->
