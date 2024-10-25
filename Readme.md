## GitHub Arm Calculator

- GitHubの特定リポジトリのRunnerをArmに変更した場合の料金を計算するツールです
- 料金は2024年10月25日時点のものです

## 使い方
- 以下のリンクを参考にGitHubの利用履歴をダウンロードします
  -  https://docs.github.com/ja/billing/managing-billing-for-your-products/managing-billing-for-github-actions/viewing-your-github-actions-usage
- `.env`を`.env.sample`から作成し、コメントを元に変数を設定します
  - PLAN: 契約中のプラン名
  - TARGET_MONTH: 料金を計算する月
  - ARMNIZING_REPOSIOTRY: Arm化するリポジトリ名
  - ALREADY_ARMNIZED_REPOSIOTRY: 既にArm化されているリポジトリ名
  - CSV_FILE_PATH: ダウンロードした利用履歴のパス
- bundle install後、`ruby main.rb`を実行します
