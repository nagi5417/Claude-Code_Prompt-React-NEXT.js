# Claude Code プロンプト集 — Next.js 15 テンプレート

Next.js 15 App Router + TypeScript strict + Prisma ORM + Tailwind CSS プロジェクト用の Claude Code 設定テンプレート。

## セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/nagi5417/Claude-Code_Prompt-React-NEXT.js.git
cd Claude-Code_Prompt-React-NEXT.js

# 依存関係インストール
pnpm install

# Claude Code を起動
claude
```

## ディレクトリ構成

```
.claude/
├── skills/                    # スラッシュコマンド＆自動スキル（13件）
│   ├── commit/
│   ├── generate-component/
│   ├── generate-api-route/
│   ├── generate-test/
│   ├── generate-e2e/
│   ├── generate-story/
│   ├── generate-types/
│   ├── generate-migration/
│   ├── code-review/
│   ├── investigate/
│   ├── plan/
│   ├── refactor/
│   └── create-pr/
├── agents/                    # 専門エージェント（4件）
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── auditor.md
│   └── design-to-code.md
├── rules/                     # パスベース自動ルール（4件）
│   ├── shared.md
│   ├── frontend.md
│   ├── backend.md
│   └── testing.md
├── hooks/                     # フック用スクリプト
│   └── format-and-lint.sh
└── settings.json              # 権限・フック設定
```

## スキル一覧

スラッシュコマンドで呼び出せます。Claude が状況を判断して自動で使うこともあります。

### コード生成

| コマンド | 説明 | 例 |
|---------|------|-----|
| `/generate-component` | React コンポーネント一式を生成 | `/generate-component Button` |
| `/generate-api-route` | REST API ルートハンドラを生成 | `/generate-api-route users` |
| `/generate-types` | ドメインの型定義を生成 | `/generate-types user` |
| `/generate-migration` | Prisma マイグレーションを生成 | `/generate-migration add-user-avatar` |
| `/generate-story` | Storybook ストーリーを生成 | `/generate-story src/components/Button/index.tsx` |

### テスト生成

| コマンド | 説明 | 例 |
|---------|------|-----|
| `/generate-test` | ユニットテストを生成 | `/generate-test src/components/Button/index.tsx` |
| `/generate-e2e` | Playwright E2E テストを生成 | `/generate-e2e auth-flow` |

### 分析

| コマンド | 説明 | 例 |
|---------|------|-----|
| `/code-review` | ブランチ差分のコードレビュー | `/code-review` |
| `/investigate` | 要件調査と方針策定 | `/investigate ユーザー認証の実装` |
| `/plan` | 実装計画の策定 | `/plan ユーザー認証の実装` |
| `/refactor` | リファクタリング | `/refactor src/lib/api-client.ts` |

### Git 操作

| コマンド | 説明 | 例 |
|---------|------|-----|
| `/commit` | Conventional Commits でコミット | `/commit` |
| `/create-pr` | GitHub PR を作成 | `/create-pr` |

## エージェント一覧

Claude が必要に応じて自動委任します。手動で指示することもできます。

| エージェント | 役割 | モデル | 呼び出し例 |
|------------|------|--------|-----------|
| test-engineer | テスト作成・修正 | sonnet | 「テストを書いて」 |
| auditor | セキュリティ/パフォーマンス/a11y 監査 | sonnet | 「セキュリティチェックして」 |
| design-to-code | Figma → コンポーネント変換 | sonnet | 「この Figma からコンポーネントを生成して」 |
| code-reviewer | コードレビュー（読み取り専用） | opus | 「レビューして」 |

## ルール（自動適用）

編集するファイルのパスに応じて、対応するルールが自動で読み込まれます。

| ルール | 適用対象 |
|--------|---------|
| `shared.md` | 全ファイル共通（TypeScript strict、インポート順序、Git 規約） |
| `frontend.md` | `src/components/**`, `app/**/*.tsx`, `hooks/**` |
| `backend.md` | `app/api/**`, `lib/db/**`, `middleware.ts` |
| `testing.md` | `**/*.test.ts(x)`, `**/*.spec.ts`, `tests/**` |

## 自動化（Hooks）

`settings.json` で以下が自動実行されます。

| タイミング | 処理 |
|-----------|------|
| ファイル編集後 | Prettier + ESLint 自動実行 |
| ファイル書き込み前 | `.env`, `package-lock.json` への書き込みブロック |
| Git push 前 | main/master への直接 push ブロック |
| セッション終了時 | `npx tsc --noEmit` 型チェック |

## カスタマイズ

### 個人設定

`.claude/settings.local.json` に個人固有の設定を追加できます（Git 管理外）。

```jsonc
{
  "permissions": {
    "allow": [
      "Bash(docker compose:*)"
    ]
  }
}
```

### ローカルスキル

`.claude/skills/` にスキルフォルダを追加すると、自分だけのスラッシュコマンドを作れます。

## 開発ワークフロー

```
1. 調査       /investigate ユーザープロフィール編集機能
2. 計画       /plan ユーザープロフィール編集機能
3. 実装       Claude に直接依頼、または /generate-component / /generate-api-route
4. テスト     /generate-test と /generate-e2e
5. レビュー   /code-review
6. コミット   /commit
7. PR 作成    /create-pr
```