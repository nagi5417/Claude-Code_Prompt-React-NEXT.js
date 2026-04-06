---
name: create-pr
description: "GitHub PR を作成する。ユーザーが「PRを作って」「プルリクエスト」「PRを出して」「マージリクエスト」と言ったときに使用する。コードの実装やレビューには使わない。"
allowed-tools: Bash(git *), Bash(gh *)
model: sonnet
---

# PR 作成

## コンテキスト（自動取得）

- ブランチ: !`git branch --show-current`
- main との差分: !`git log main..HEAD --oneline`
- 変更ファイル: !`git diff main --name-only`
- 変更統計: !`git diff main --stat`

## ワークフロー

1. 変更内容を分析し PR タイトルと本文を生成する
2. `git push -u origin $(git branch --show-current)` でプッシュする
3. `gh pr create` で PR を作成する

## PR テンプレート

```markdown
## 概要
<!-- 変更の目的と背景 -->

## 変更内容
<!-- 主な変更点を箇条書き -->

## テスト
- [ ] ユニットテスト通過
- [ ] E2Eテスト通過
- [ ] 型チェック通過
- [ ] リント通過

## スクリーンショット
<!-- UI変更がある場合 -->
```

## 完了条件

- ブランチがリモートにプッシュされている
- PR が作成され、タイトルと本文が適切に記載されている