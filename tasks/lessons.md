# 学びの記録

<!-- ユーザーからの修正指示に基づき、ミスのパターンと対策を蓄積する -->
<!-- セッション開始時に必ず確認すること -->

## ルール

- Server Component で fetch を使って自分の API Route を呼ばないこと（Prisma を直接使う）
- App Router の params は Promise なので await が必要

## よくあるエラーと対処

### "Module not found" エラー

原因: パスエイリアス `@/` の解決失敗
対処: `tsconfig.json` の `paths` 設定を確認

### Prisma Client が見つからない

原因: `prisma generate` が未実行
対処: `npx prisma generate` を実行

### Hydration mismatch エラー

原因: Server Component と Client Component の境界で不整合
対処: `'use client'` の配置を確認。`Date` や `Math.random()` を Server Component で使っていないか確認

### "params is not iterable" エラー

原因: App Router の params を await せずに使用
対処: `const { id } = await params;` のように await する