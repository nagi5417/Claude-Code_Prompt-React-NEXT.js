---
name: generate-api-route
description: "Next.js API Route Handler を生成する。ユーザーが「APIを作って」「エンドポイントを追加して」「REST APIを実装して」「CRUDを作って」と言ったときに使用する。フロントエンド実装やテスト作成には使わない。"
argument-hint: <resource-name> (例: users, products)
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(npx tsc:*), Bash(pnpm build:*)
model: sonnet
---

# API Route 生成: /api/v1/$ARGUMENTS

## 事前準備

1. `prisma/schema.prisma` を読み込み、$ARGUMENTS に対応する Prisma モデルを特定する
2. モデルのフィールド定義に基づいて実装する（テンプレートは `references/api-route-template.md` を参照）

## 生成するファイル

1. `app/api/v1/$ARGUMENTS/route.ts` — GET（一覧+ページネーション）、POST（作成）
2. `app/api/v1/$ARGUMENTS/[id]/route.ts` — GET（単一）、PUT（更新）、DELETE（削除）

## 制約

- `NextRequest` / `NextResponse` を `next/server` からインポート
- リクエストボディのバリデーションに Zod を使用
- エラーレスポンスは `lib/api-error.ts` の統一形式を使用
- Prisma Client は `lib/db/index.ts` からシングルトンインポート

## 検証ワークフロー

以下を順番に実行し、エラーがあれば修正して再実行する（最大3回）:

1. `npx tsc --noEmit` → 型チェック
2. `pnpm build` → ビルド確認

## 完了条件

- 2つの route.ts が存在し、全 HTTP メソッドが実装されている
- Zod バリデーション付き
- 統一エラーレスポンス形式を使用
- `npx tsc --noEmit` と `pnpm build` がエラーなし