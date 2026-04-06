---
name: refactor
description: "指定ファイルやモジュールのリファクタリングを実施する。ユーザーが「リファクタして」「整理して」「きれいにして」「コードを改善して」と言ったときに使用する。新機能の実装やバグ修正には使わない。動作の変更がない pure refactoring のみ。"
argument-hint: <file-path-or-directory>
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(pnpm test:*), Bash(pnpm lint:*), Bash(npx tsc:*)
model: sonnet
---

# リファクタリング: $ARGUMENTS

## ワークフロー

1. **現状分析**: ファイルサイズ、複雑度、依存関係を確認する
2. **計画策定**: 変更内容を一覧化し、リスクを評価する
3. **テスト確認**: 既存テストが通ることを確認する（`pnpm test -- --run`）
4. **実施**: 改善を適用する
5. **検証**: テスト再実行 + 型チェック + リント

## 改善対象

- 長い関数の分割（1関数 50行以内目標）
- 重複コードの共通化
- マジックナンバーの定数化
- 型の厳格化（`any` → 具体型）
- 不要な依存の除去
- Early return パターンの適用

## 制約

- 外部インターフェース（エクスポートされた型・関数のシグネチャ）は変更しない
- 動作の変更がない pure refactoring のみ実施
- 変更が大きい場合は段階的にコミット

## 完了条件

- `pnpm test -- --run` で全テスト通過（リファクタリング前と同じ結果）
- `pnpm lint` がエラーなし
- `npx tsc --noEmit` がエラーなし