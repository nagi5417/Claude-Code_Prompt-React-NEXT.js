---
name: generate-component
description: "React コンポーネントを規約に沿って生成する。ユーザーが「コンポーネントを作って」「UIを作って」「画面を作って」と言ったときに使用する。テスト作成やリファクタリングには使わない。"
argument-hint: <ComponentName>
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(pnpm lint), Bash(pnpm test:*), Bash(npx tsc:*)
model: sonnet
---

# コンポーネント生成: $ARGUMENTS

## 事前調査

1. `components/ui/` に同等のコンポーネントが既に存在しないか確認する
2. Storybook が導入されているか確認する（`.storybook/` または `package.json` の `storybook` スクリプト）

## 生成ファイル

`src/components/$ARGUMENTS/` ディレクトリに以下を生成する:

| ファイル | 内容 | 条件 |
|---|---|---|
| `index.tsx` | コンポーネント本体 | 必須 |
| `index.test.tsx` | ユニットテスト | 必須 |
| `index.stories.tsx` | Storybook ストーリー | Storybook 導入時のみ |
| `index.ts` | バレルエクスポート | 必須 |

テンプレートと規約の詳細は `references/component-templates.md` を参照すること。

## 検証ループ（最大3回）

1. `pnpm lint` → エラーがあれば修正
2. `pnpm test -- --run src/components/$ARGUMENTS` → 失敗したら原因分析して修正
3. `npx tsc --noEmit` → 型エラーがあれば修正
4. すべて通過したら完了を報告

## 完了条件

- [ ] `src/components/$ARGUMENTS/index.tsx` が存在し named export されている
- [ ] `src/components/$ARGUMENTS/index.test.tsx` が存在しテスト通過
- [ ] `src/components/$ARGUMENTS/index.ts` がバレルエクスポートとして存在
- [ ] Storybook 導入時のみ `index.stories.tsx` が存在
- [ ] `pnpm lint` エラーなし
- [ ] `npx tsc --noEmit` エラーなし

## 判断基準

- 既存の `components/ui/` に類似コンポーネントがある → 新規作成せず既存を使うよう提案
- Props が5個超 → 複数コンポーネントへの分割を検討
- 200行超になりそう → 分割を提案