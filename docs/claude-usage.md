# Claude Code 運用ガイド

このドキュメントでは、本テンプレートに組み込まれた Claude Code の設定・コマンド・エージェント・自動化について解説します。

## 1. 概要

`.claude/` フォルダにはチーム共通の Claude Code 設定がすべて格納されています。

```
.claude/
├── agents/                    # サブエージェント定義（5件）
│   ├── accessibility-auditor.md
│   ├── code-reviewer.md
│   ├── performance-auditor.md
│   ├── security-auditor.md
│   └── test-engineer.md
├── commands/                  # スラッシュコマンド（13件）
│   ├── commit.md
│   ├── create-pr.md
│   ├── generate-api-route.md
│   ├── generate-component.md
│   ├── generate-e2e.md
│   ├── generate-migration.md
│   ├── generate-story.md
│   ├── generate-test.md
│   ├── generate-types.md
│   ├── investigate.md
│   ├── plan.md
│   ├── refactor.md
│   └── review.md
├── hooks/                     # フック用スクリプト
│   └── format-and-lint.sh
├── rules/                     # パスベースルール（4件）
│   ├── shared.md
│   ├── frontend.md
│   ├── backend.md
│   └── testing.md
├── settings.json              # チーム共通設定（権限・フック）
└── settings.local.json        # 個人設定（Git 管理外）
```

### 各レイヤーの役割

| レイヤー        | 役割                                                           |
| --------------- | -------------------------------------------------------------- |
| `CLAUDE.md`     | プロジェクト全体の技術スタック・コマンド・コードスタイルの定義 |
| `rules/`        | ファイルパスに応じたコーディング規約の自動適用                 |
| `commands/`     | スラッシュコマンドによる定型タスクの実行                       |
| `agents/`       | 専門知識を持つサブエージェントへのタスク委任                   |
| `hooks/`        | ツール実行前後の自動チェック・フォーマット                     |
| `settings.json` | 許可・拒否リストとフック設定                                   |

## 2. クイックスタート

### Claude Code の起動

```bash
# プロジェクトルートで起動
claude

# または特定のタスクを直接指定
claude "ログイン機能を実装して"
```

### 最初に試すべきコマンド

```
# コードレビュー（現在のブランチの差分をレビュー）
/review

# コンポーネント生成
/generate-component Button

# テスト生成
/generate-test src/components/Button/index.tsx

# コミット（Conventional Commits 形式で自動生成）
/commit
```

## 3. スラッシュコマンド一覧

### コード生成系（7件）

#### `/generate-component <ComponentName>`

React コンポーネントを規約に沿って生成します。

```
/generate-component Button
```

生成されるファイル:

- `src/components/Button/index.tsx` — コンポーネント本体（Server Component）
- `src/components/Button/index.test.tsx` — ユニットテスト
- `src/components/Button/index.stories.tsx` — Storybook ストーリー
- `src/components/Button/index.ts` — バレルエクスポート

#### `/generate-api-route <resource-name>`

REST API ルートハンドラを生成します。

```
/generate-api-route users
```

生成されるファイル:

- `app/api/v1/users/route.ts` — GET（一覧）+ POST（作成）
- `app/api/v1/users/[id]/route.ts` — GET（詳細）+ PUT（更新）+ DELETE（削除）

Zod バリデーション、統一エラーレスポンス、ページネーション対応が含まれます。

#### `/generate-test <file-path>`

指定ファイルのユニットテストを生成します。

```
/generate-test src/components/Button/index.tsx
```

- AAA パターン（Arrange-Act-Assert）
- `vi.mock()` による依存モック、msw による API モック
- 正常系・エッジケース・エラー系を網羅

#### `/generate-e2e <feature-name>`

Playwright による E2E テストを生成します。

```
/generate-e2e auth-flow
```

- Page Object Model を使用
- ハッピーパス、エラーシナリオ、モバイルビューポートをカバー
- `tests/e2e/<feature-name>.spec.ts` に出力

#### `/generate-story <component-path>`

Storybook ストーリーを生成します。

```
/generate-story src/components/Button/index.tsx
```

- Default、バリエーション、Loading、Error、Empty の各ストーリー
- `satisfies Meta<typeof Component>` による型安全なストーリー定義

#### `/generate-migration <migration-description>`

Prisma マイグレーションを生成します。

```
/generate-migration add-user-avatar
```

- スキーマ変更 → フォーマット → マイグレーション生成 → 型生成を一括実行
- 破壊的変更（DROP、ALTER COLUMN）がある場合は警告

#### `/generate-types <domain-name>`

API レスポンスやフォームの型定義を生成します。

```
/generate-types user
```

生成される型:

- エンティティ型（ベース）
- API レスポンス型（`UserResponse`, `UserListResponse`）
- フォーム入力型（`CreateUserInput`, `UpdateUserInput`）
- クエリパラメータ型（`UserQueryParams`）

### 分析系（3件）

#### `/review`

現在のブランチの変更差分を包括的にレビューします。引数は不要です。

```
/review
```

レビュー観点（優先度順）:

1. バグ・ロジックエラー
2. セキュリティ（SQLi, XSS, 認証バイパス, シークレット露出）
3. 型安全性（TS エラー, `as` キャスト, `any` 型）
4. エラーハンドリング
5. パフォーマンス（再レンダリング, N+1 クエリ, バンドルサイズ）
6. アクセシビリティ
7. テストカバレッジ

重要度 80 以上の問題のみ報告されます。

#### `/refactor <file-path-or-directory>`

指定ファイルまたはディレクトリをリファクタリングします。

```
/refactor src/lib/api-client.ts
```

- 関数分割（50行以下）、重複排除、マジックナンバー抽出
- `any` → 具象型への変換、デッドコード削除
- リファクタリング前後でテストが通ることを確認

#### `/investigate <task-description>`

要件を調査し、実装方針を文書化します。

```
/investigate ユーザー認証の実装
```

- 関連ファイルの分析、技術的制約の調査、選択肢の比較
- `docs/investigate/investigate_<task>.md` に調査結果を出力

### Git 操作系（3件）

#### `/commit`

Conventional Commits 形式でコミットメッセージを自動生成してコミットします。引数は不要です。

```
/commit
```

コミットメッセージ形式:

```
<type>(<scope>): <50文字以内の要約>

- 変更点1の説明
- 変更点2の説明

Generated with Claude Code
```

type: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

#### `/create-pr`

GitHub PR を作成します。引数は不要です。

```
/create-pr
```

- ブランチのプッシュと PR 作成を一括実行
- 概要・変更内容・テストチェックリストを含む PR 本文を自動生成

#### `/plan <task-description>`

調査結果に基づく実装計画を策定します。

```
/plan ユーザー認証の実装
```

- `docs/investigate/` の調査結果を参照
- スコープ定義、タスク分解、依存関係の整理
- `docs/plan/plan_<task>.md` に計画を出力

## 4. エージェント一覧

エージェントは特定の専門知識を持つサブプロセスで、Claude Code が必要に応じて自動的に委任します。手動で呼び出す場合はプロンプトで指示します。

> **Note:** フロントエンド・バックエンドの開発タスクは `rules/frontend.md` と `rules/backend.md` で十分カバーされるため、専用エージェントは設けていません。コンポーネント作成は `/generate-component`、API ルート作成は `/generate-api-route` コマンドを使用してください。

### テスト系

#### test-engineer

ユニットテスト・E2E テストの作成を担当します。

- **モデル:** sonnet
- **得意領域:** Vitest + React Testing Library、Playwright、Page Object Model、msw によるモック
- **カバレッジ目標:** 全体 80%、クリティカルパス 95%
- **使いどころ:** テスト追加、テスト修正、カバレッジ向上

```
テストエージェントにログインフォームのテストを書かせて
```

### 監査系

#### performance-auditor

パフォーマンス監査を実施します。

- **モデル:** sonnet
- **監査項目:** Core Web Vitals（LCP/INP/CLS）、バンドルサイズ、レンダリング最適化、データフェッチ、画像・フォント最適化
- **使いどころ:** パフォーマンス改善の前に現状を把握したいとき

```
パフォーマンス監査を実施して
```

#### accessibility-auditor

WCAG 2.1 AA 準拠のアクセシビリティ監査を実施します。

- **モデル:** sonnet
- **監査項目:** セマンティック HTML、ARIA 属性、キーボード操作、色コントラスト、フォーム、動的コンテンツ、画像 alt テキスト
- **使いどころ:** アクセシビリティ対応の確認、リリース前チェック

```
アクセシビリティ監査を実施して
```

#### security-auditor

OWASP Top 10 に基づくセキュリティ監査を実施します。

- **モデル:** sonnet
- **監査項目:** 認証・認可、入力バリデーション（XSS/SQLi/パストラバーサル）、ハードコードされたシークレット、API セキュリティ（レート制限/CORS/CSRF）、Server Component のデータ漏洩
- **使いどころ:** セキュリティレビュー、リリース前チェック

```
セキュリティ監査を実施して
```

#### code-reviewer

シニアレベルのコードレビューを実施します。

- **モデル:** opus（他のエージェントより高精度）
- **レビュー観点:** 確実なバグ、CLAUDE.md / rules 違反（具体的なルールを引用）、セキュリティ脆弱性（攻撃シナリオ付き）、型安全性の問題
- **使いどころ:** PR マージ前の最終レビュー

```
コードレビューエージェントにレビューを依頼して
```

## 5. 自動化（Hooks）

`settings.json` に定義されたフックにより、以下の自動化が実行されます。

### PostToolUse: Prettier 自動フォーマット + ESLint 自動修正

ファイル編集後、1つの統合フックで以下が順番に自動実行されます:

1. 対象ファイル（`.ts`, `.tsx`, `.js`, `.jsx`, `.json`, `.css`, `.md`）に `npx prettier --write`
2. 対象ファイル（`.ts`, `.tsx`, `.js`, `.jsx`）に `npx eslint --fix`

### PreToolUse: 保護対象ファイルのブロック

以下のファイルへの書き込みが自動的にブロックされます:

- `.env`（および `.env.*`）
- `package-lock.json`
- `.git/` 配下
- `node_modules/` 配下

### PreToolUse: main ブランチへの直接 push 防止

`git push origin main` および `git push origin master` が自動的にブロックされます。

### Stop: TypeScript 型チェック

Claude Code のセッション終了時に `npx tsc --noEmit` が実行され、型エラーがないことを確認します。

### Notification: macOS サウンド通知

タスク完了時に macOS のシステムサウンド（Glass.aiff）が再生されます。

## 6. パスベースルール

`.claude/rules/` 内のルールファイルは、編集対象のファイルパスに応じて自動的に適用されます。

### shared.md（全ファイルに適用）

- TypeScript strict モード、`any` 型禁止
- 未使用変数は `_` プレフィックス
- `enum` より `const object + as const` を推奨
- 型アサーション（`as`）は最終手段
- インポート順序: `react` → `next` → 外部ライブラリ → `@/` 内部パス → `./` 相対パス
- Conventional Commits 形式

### frontend.md（コンポーネント・ページに適用）

**対象:** `src/components/**/*.tsx`, `src/components/**/*.ts`, `app/**/*.tsx`, `hooks/**/*.ts`

- Server Components をデフォルト使用（`'use client'` は `useState` / `useEffect` 使用時のみ）
- Props は `interface` で定義（`ComponentNameProps`）
- 1 コンポーネント 200 行以内
- Tailwind ユーティリティのみ、CVA でバリアント管理、`cn()` でクラス結合
- `next/dynamic` + `ssr: false` で重いコンポーネントを遅延ロード
- Server Actions + `useActionState` でフォーム処理

### backend.md（API・DB に適用）

**対象:** `app/api/**/*.ts`, `lib/db/**/*.ts`, `lib/api-error.ts`, `middleware.ts`

- HTTP メソッドごとに named export（`GET`, `POST`, `PUT`, `DELETE`）
- Zod でリクエストボディをバリデーション
- 統一エラーフォーマット: `{ error: string; details?: unknown; statusCode: number }`
- Prisma Client はシングルトン（`lib/db/index.ts`）
- `db.$transaction()` で複数テーブル更新
- レート制限（`lib/rate-limit.ts`）、入力サニタイズ

### testing.md（テストファイルに適用）

**対象:** `**/*.test.ts`, `**/*.test.tsx`, `**/*.spec.ts`, `tests/**/*`

- AAA パターン（Arrange-Act-Assert）
- クエリ優先順位: `getByRole` > `getByLabelText` > `getByText` > `getByTestId`
- `vi.mock()` で依存モック、msw で API モック
- E2E は Page Object Model を使用
- カバレッジ: 全体 80% 以上、クリティカルパス 95% 以上

## 7. 安全ガードレール

### deny リスト（settings.json）

以下の操作は `settings.json` で明示的に拒否されています:

| 操作                               | 理由                               |
| ---------------------------------- | ---------------------------------- |
| `Bash(rm -rf:*)`                   | 再帰的ファイル削除の防止           |
| `Bash(git push origin main:*)`     | main ブランチへの直接 push 防止    |
| `Bash(git push origin master:*)`   | master ブランチへの直接 push 防止  |
| `Bash(npx prisma migrate reset:*)` | DB の意図しないリセット防止        |
| `Read(./.env)`, `Read(./.env.*)`   | 環境変数ファイルの読み取り防止     |
| `Read(./secrets/**)`               | シークレットファイルの読み取り防止 |
| `Write(.env*)`                     | 環境変数ファイルの書き込み防止     |
| `Write(package-lock.json)`         | ロックファイルの意図しない変更防止 |
| `DeleteFile(src/*)`                | ソースコードの意図しない削除防止   |
| `DeleteFile(.env*)`                | 環境変数ファイルの削除防止         |

### フックによる保護

- **ファイル書き込みガード:** `.env`, `package-lock.json`, `.git/`, `node_modules/` への書き込みをブロック
- **ブランチ保護:** `git push` の `main` / `master` ブランチ指定をブロック

### 多層防御

安全性は deny リスト + PreToolUse フックの 2 層で担保されています。deny リストは Claude Code の権限レベルで操作を拒否し、フックはツール実行直前にコマンド内容を検査してブロックします。

## 8. 開発ワークフロー例

典型的な機能開発フロー:

```
1. 調査       /investigate ユーザープロフィール編集機能
2. 計画       /plan ユーザープロフィール編集機能
3. 実装       Claude Code 本体に直接依頼、または /generate-component / /generate-api-route を使用
4. テスト     /generate-test と /generate-e2e でテスト生成
5. レビュー   /review で差分レビュー
6. コミット   /commit で Conventional Commits 形式のコミット
7. PR 作成    /create-pr で GitHub PR 作成
```

各ステップは独立して実行できます。たとえば、既存コードの修正であれば調査・計画をスキップして実装から始めることもできます。

## 9. カスタマイズ方法

### 個人設定（settings.local.json）

`.claude/settings.local.json` は Git 管理外のファイルで、個人固有の設定を追加できます。チーム共通の `settings.json` を上書きせずに、自分だけの許可ルールやフックを追加する用途で使用します。

```jsonc
// .claude/settings.local.json の例
{
  "permissions": {
    "allow": [
      "Bash(docker compose:*)", // 個人環境の Docker 操作を許可
    ],
  },
}
```

### ローカルコマンド（.claude/commands/local/）

`.claude/commands/local/` ディレクトリに `.md` ファイルを作成することで、Git にコミットされないローカル専用のスラッシュコマンドを追加できます。

```markdown
<!-- .claude/commands/local/my-debug.md -->

以下のデバッグ手順を実行してください:

1. ...
```

### ローカルフック（.claude/hooks/local/）

`.claude/hooks/local/` ディレクトリにスクリプトを配置し、`settings.local.json` から参照することで、個人専用のフックを追加できます。
