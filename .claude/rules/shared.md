# 共通コーディング規約

## TypeScript

- strict モード必須。any 型は絶対に使用しない
- 未使用変数は `_` プレフィックス
- enum よりも const object + `as const` を推奨
- 型アサーション（as）は最終手段。型ガードを優先

## インポート

- 順序: react → next → 外部ライブラリ → @/ 内部パス → ./ 相対パス
- バレルエクスポート（index.ts）を活用

## Git

- Conventional Commits: feat: / fix: / refactor: / test: / docs: / chore:
- 1コミット1論理変更
- main ブランチへの直接プッシュ禁止

## ドキュメント

- 公開関数には JSDoc コメント
- 複雑なロジックにはインラインコメント
- コードが自明な箇所にはコメント不要（自己文書化を優先）
