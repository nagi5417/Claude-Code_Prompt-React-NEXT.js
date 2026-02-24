---
description: GitHub PR を作成
allowed-tools: Bash(git *), Bash(gh *)
---

## コンテキスト

- ブランチ: !`git branch --show-current`
- main との差分: !`git log main..HEAD --oneline`
- 変更ファイル: !`git diff main --name-only`
- 変更統計: !`git diff main --stat`

## タスク

1. 変更内容を分析し PR タイトルと本文を生成
2. `git push -u origin $(git branch --show-current)`
3. `gh pr create` で PR を作成

### PR テンプレート

```
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
