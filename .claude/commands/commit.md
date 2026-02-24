---
description: Conventional Commits 形式でコミットメッセージを生成
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
---

## コンテキスト

- git status: !`git status --short`
- git diff (staged): !`git diff --cached --stat`
- git diff (unstaged): !`git diff --stat`
- 現在のブランチ: !`git branch --show-current`
- 最近のコミット: !`git log --oneline -5`

## タスク

1. 変更内容を分析
2. Conventional Commits 形式でコミットメッセージを作成:
   - `feat:` 新機能
   - `fix:` バグ修正
   - `refactor:` リファクタリング
   - `test:` テスト追加/修正
   - `docs:` ドキュメント
   - `chore:` その他
3. スコープを付与（例: `feat(auth):`, `fix(api):`）
4. 本文に変更の要約を箇条書きで記載
5. `git add` → `git commit` を実行

フォーマット:

```
<type>(<scope>): <50文字以内の要約>

- 変更点1の説明
- 変更点2の説明

🤖 Generated with Claude Code
```
