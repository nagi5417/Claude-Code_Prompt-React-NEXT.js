---
paths:
  - "app/api/**/*.ts"
  - "lib/db/**/*.ts"
  - "lib/api-error.ts"
  - "middleware.ts"
---

<!-- 🔴 プロジェクト固有: Prisma/PostgreSQL 依存 -->

# バックエンド開発規約

## API Route Handler

- HTTP メソッド別に named export（GET, POST, PUT, DELETE）
- リクエストボディは必ず Zod でバリデーション
- レスポンス型を明示的に定義
- エラーレスポンスは `lib/api-error.ts` の統一形式を使用
- 認証が必要なルートは middleware.ts でガード

## データベース

- Prisma Client は `lib/db/index.ts` からシングルトンインポート
- select/include を明示し、不要なフィールドを取得しない
- 複数テーブル更新時は `db.$transaction()` を使用
- N+1 防止: リスト取得は必ず include で関連データを同時取得

## エラーハンドリング

```typescript
// 統一エラー形式
{ error: string; details?: unknown; statusCode: number }
```

## セキュリティ

- レート制限を考慮（重要なエンドポイントには `lib/rate-limit.ts` を適用）
- 入力サニタイゼーション必須
- .env 値はサーバーサイドのみで使用（NEXT*PUBLIC* プレフィックス禁止）
