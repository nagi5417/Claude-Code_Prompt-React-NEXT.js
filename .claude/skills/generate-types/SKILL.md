---
name: generate-types
description: "API レスポンスやフォームの型定義を生成する。ユーザーが「型を作って」「型定義を追加して」「TypeScriptの型を生成して」と言ったときに使用する。Prisma スキーマに基づいてドメインの型を一括生成する。"
argument-hint: <domain-name> (例: user, product, order)
allowed-tools: Read, Write, Edit, Glob, Grep
model: sonnet
---

# 型定義生成: $ARGUMENTS

`prisma/schema.prisma` を読み込み、`src/types/$ARGUMENTS.ts` に型定義を生成する。

## 生成する型

1. **エンティティ型**: Prisma モデルに基づく基本型
2. **API レスポンス型**: `${ARGUMENTS}Response`, `${ARGUMENTS}ListResponse`
3. **フォーム型**: `Create${ARGUMENTS}Input`, `Update${ARGUMENTS}Input`（Zod スキーマと同期）
4. **クエリパラメータ型**: `${ARGUMENTS}QueryParams`（ページネーション、フィルタ、ソート）

## 制約

- `interface` を公開 API に使用、`type` は内部ユーティリティに使用
- Zod スキーマから `z.infer<>` で型を導出
- すべての型に JSDoc コメント
- named export のみ

## 完了条件

- `src/types/$ARGUMENTS.ts` が存在
- 4種類の型（エンティティ、レスポンス、フォーム、クエリ）が定義されている
- `npx tsc --noEmit` がエラーなし