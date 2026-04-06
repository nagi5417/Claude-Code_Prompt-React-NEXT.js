---
name: generate-migration
description: "Prisma マイグレーションを生成する。ユーザーが「マイグレーション」「DBスキーマを変更して」「テーブルを追加して」「カラムを追加して」と言ったときに使用する。データの投入やシード作成には使わない。"
argument-hint: <migration-description> (例: add-user-avatar)
allowed-tools: Read, Write, Edit, Bash(npx prisma:*), Bash(npx tsc:*)
model: sonnet
---

# マイグレーション生成: $ARGUMENTS

## ワークフロー

1. `prisma/schema.prisma` を読み込み、現在のスキーマを把握する
2. $ARGUMENTS の要件に基づきスキーマを修正する
3. 以下を実行する:
   ```bash
   npx prisma format
   npx prisma migrate dev --name $ARGUMENTS
   npx prisma generate
   ```
4. 生成されたマイグレーション SQL を確認する
5. `npx tsc --noEmit` で型定義の更新を確認する

## スキーマ規約

- テーブル名: snake_case 複数形（users, order_items）
- カラム名: snake_case（created_at, updated_at）
- すべてのテーブルに `id`, `created_at`, `updated_at` を含める
- 外部キーには適切なインデックスを設定
- enum は PascalCase（UserRole, OrderStatus）
- ID のデフォルト値: `@default(cuid())`

## 安全チェック

デストラクティブな変更（DROP TABLE, DROP COLUMN, ALTER COLUMN 型変更）が含まれる場合、実行前にユーザーに警告し確認を取る。

## 完了条件

- スキーマが修正され、`npx prisma format` が通る
- マイグレーションが正常に生成されている
- `npx tsc --noEmit` がエラーなし