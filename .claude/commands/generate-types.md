---
description: APIレスポンスやフォームの型定義を生成
argument-hint: <domain-name> (例: user, product, order)
---

<!-- 🔴 プロジェクト固有: Prisma + Zod 依存 -->

## 型定義: $ARGUMENTS

`src/types/$ARGUMENTS.ts` に型定義ファイルを生成してください。

### 生成する型

1. **エンティティ型**: Prisma スキーマ（@prisma/schema.prisma）に基づく基本型
2. **API レスポンス型**: `${ARGUMENTS}Response`, `${ARGUMENTS}ListResponse`
3. **フォーム型**: `Create${ARGUMENTS}Input`, `Update${ARGUMENTS}Input`（Zod スキーマと同期）
4. **クエリパラメータ型**: `${ARGUMENTS}QueryParams`（ページネーション、フィルタ、ソート）

### 規約

- `interface` を公開 API に使用、`type` は内部ユーティリティに使用
- Zod スキーマから `z.infer<>` で型を導出
- すべての型に JSDoc コメント
- named export のみ
