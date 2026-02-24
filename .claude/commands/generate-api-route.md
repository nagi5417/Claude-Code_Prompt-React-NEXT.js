---
description: Next.js API Route Handler を生成
argument-hint: <resource-name> (例: users, products)
---

## API Route: /api/v1/$ARGUMENTS

`app/api/v1/$ARGUMENTS/route.ts` に Next.js Route Handler を生成してください。

### 規約

1. `NextRequest` / `NextResponse` を `next/server` からインポート
2. リクエストボディのバリデーションに Zod を使用
3. try/catch でエラーハンドリング
4. 統一エラーレスポンス形式（`lib/api-error.ts`）を使用

### テンプレート

```typescript
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { db } from "@/lib/db";
import { ApiError, handleApiError } from "@/lib/api-error";

// バリデーションスキーマ
const createSchema = z.object({
  // $ARGUMENTS のフィールド定義
});

const updateSchema = createSchema.partial();

// GET /api/v1/$ARGUMENTS
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const limit = Number(searchParams.get("limit") ?? "20");
    const offset = Number(searchParams.get("offset") ?? "0");

    const data = await db.$ARGUMENTS.findMany({
      take: limit,
      skip: offset,
    });
    const total = await db.$ARGUMENTS.count();

    return NextResponse.json({ data, total, limit, offset }, { status: 200 });
  } catch (error) {
    return handleApiError(error);
  }
}

// POST /api/v1/$ARGUMENTS
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validated = createSchema.parse(body);
    const created = await db.$ARGUMENTS.create({ data: validated });
    return NextResponse.json({ data: created }, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: "Validation Error", details: error.errors },
        { status: 400 },
      );
    }
    return handleApiError(error);
  }
}
```

### 動的ルート（個別リソース）

`app/api/v1/$ARGUMENTS/[id]/route.ts` も同時に生成し、GET（単一取得）、PUT（更新）、DELETE（削除）を実装してください。

### 生成後の検証

- `npx tsc --noEmit` で型チェック
- `pnpm build` でビルド確認
