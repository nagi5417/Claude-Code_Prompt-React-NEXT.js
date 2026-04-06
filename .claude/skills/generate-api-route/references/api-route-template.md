# API Route テンプレート

## route.ts（一覧 + 作成）

```typescript
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { db } from "@/lib/db";
import { ApiError, handleApiError } from "@/lib/api-error";

// バリデーションスキーマ（Prisma モデルのフィールドに基づいて定義）
const createSchema = z.object({
  // フィールド定義
});

const updateSchema = createSchema.partial();

// GET /api/v1/${resource}
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const limit = Number(searchParams.get("limit") ?? "20");
    const offset = Number(searchParams.get("offset") ?? "0");

    const data = await db.${model}.findMany({
      take: limit,
      skip: offset,
    });
    const total = await db.${model}.count();

    return NextResponse.json({ data, total, limit, offset }, { status: 200 });
  } catch (error) {
    return handleApiError(error);
  }
}

// POST /api/v1/${resource}
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validated = createSchema.parse(body);
    const created = await db.${model}.create({ data: validated });
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

## [id]/route.ts（単一取得 + 更新 + 削除）

```typescript
import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/db";
import { handleApiError } from "@/lib/api-error";

// GET /api/v1/${resource}/[id]
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> },
) {
  try {
    const { id } = await params;
    const item = await db.${model}.findUnique({ where: { id } });
    if (!item) {
      return NextResponse.json({ error: "Not Found" }, { status: 404 });
    }
    return NextResponse.json({ data: item }, { status: 200 });
  } catch (error) {
    return handleApiError(error);
  }
}

// PUT /api/v1/${resource}/[id]
export async function PUT(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> },
) {
  try {
    const { id } = await params;
    const body = await request.json();
    const validated = updateSchema.parse(body);
    const updated = await db.${model}.update({
      where: { id },
      data: validated,
    });
    return NextResponse.json({ data: updated }, { status: 200 });
  } catch (error) {
    return handleApiError(error);
  }
}

// DELETE /api/v1/${resource}/[id]
export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> },
) {
  try {
    const { id } = await params;
    await db.${model}.delete({ where: { id } });
    return NextResponse.json(null, { status: 204 });
  } catch (error) {
    return handleApiError(error);
  }
}
```

## 注意事項

- `params` は Promise なので必ず `await` する（App Router の仕様）
- リソース名（$ARGUMENTS）と Prisma モデル名の対応を確認すること（例: `users` → `user`）
- select/include を明示し、不要なフィールドを取得しない
- 複数テーブル更新時は `db.$transaction()` を使用