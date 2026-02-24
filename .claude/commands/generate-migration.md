---
description: Prisma マイグレーションを生成
argument-hint: <migration-description> (例: add-user-avatar)
---

## マイグレーション: $ARGUMENTS

### 手順

1. `prisma/schema.prisma` を読み込み、現在のスキーマを理解
2. `$ARGUMENTS` の要件に基づきスキーマを修正
3. 以下を実行:

```bash
npx prisma format
npx prisma migrate dev --name $ARGUMENTS
npx prisma generate
```

4. 生成されたマイグレーション SQL を確認し、デストラクティブな変更（DROP, ALTER COLUMN 型変更）がないか検証
5. 型定義の更新を確認（`npx tsc --noEmit`）

### 規約

- テーブル名は snake_case 複数形（users, order_items）
- カラム名は snake_case（created_at, updated_at）
- すべてのテーブルに id, created_at, updated_at を含める
- 外部キーには適切なインデックスを設定
- enum は PascalCase（UserRole, OrderStatus）
- `@default(cuid())` を ID のデフォルト値に使用
