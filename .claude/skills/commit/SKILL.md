---
name: commit
description: "Conventional Commits 形式でコミットメッセージを生成しコミットする。ユーザーが「コミットして」「変更を保存して」「commitして」「今の変更をまとめて」と言ったときに使用する。git操作のみ。コードの変更や実装には使わない。"
argument-hint: "[メッセージの補足（省略可）]"
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
model: sonnet
---

# Conventional Commits コミット

## コンテキスト（自動取得）

- git status: !`git status --short`
- staged: !`git diff --cached --stat`
- unstaged: !`git diff --stat`
- ブランチ: !`git branch --show-current`
- 直近コミット: !`git log --oneline -5`

## ワークフロー

1. 上記コンテキストから変更内容を把握する
2. unstaged の変更があれば `git add` で適切にステージングする
3. 変更内容に最も合う type と scope を選び、コミットメッセージを生成する
4. `git commit` を実行する

## コミットメッセージ規約

type は以下から選択:

- `feat`: 新機能
- `fix`: バグ修正
- `refactor`: リファクタリング（動作変更なし）
- `test`: テスト追加・修正
- `docs`: ドキュメント
- `chore`: ビルド、CI、依存関係などの雑務

scope は変更の影響範囲を括弧で付与（例: `feat(auth):`、`fix(api):`）。

## フォーマット

```
<type>(<scope>): <50文字以内の日本語要約>

- 変更点1の説明
- 変更点2の説明

🤖 Generated with Claude Code
```

## 判断基準

- 複数の論理変更が混在 → ユーザーに分割コミットを提案する
- 変更が1ファイルのみ → scope はファイル名またはディレクトリ名
- 変更が広範囲 → scope は省略可