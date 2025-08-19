# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 既存のデータを全て削除してから作成する
Changelog.destroy_all

Changelog.create!([
  { published_on: '2025-08-19', content: '<span class="badge bg-success me-2">NEW</span>個人設定ページを追加し、名前を変更できるようにしました。' },
  { published_on: '2025-08-19', content: '<span class="badge bg-info me-2">UPDATE</span>ユーザーメニューをドロップダウン形式に変更しました。' },
  { published_on: '2025-08-14', content: '<span class="badge bg-success me-2">NEW</span>ゲストログイン機能を追加しました。' },
  { published_on: '2025-08-14', content: '<span class="badge bg-success me-2">NEW</span>記録の詳細ページからXに投稿をシェアできる機能を追加しました。' },
  { published_on: '2025-08-13', content: '<span class="badge bg-success me-2">NEW</span>コピー機能を追加しました。' },
  { published_on: '2025-08-13', content: '<span class="badge bg-info me-2">UPDATE</span>記録の詳細表示ページを統合しました。' },
  { published_on: '2025-08-11', content: '<span class="badge bg-success me-2">NEW</span>アイコンを新しいデザインに変更しました。' },
  { published_on: '2025-08-10', content: '<span class="badge bg-success me-2">NEW</span>利用規約とプライバシーポリシーのページを追加しました。' },
  { published_on: '2025-08-10', content: '<span class="badge bg-info me-2">UPDATE</span>サイト全体の日本語化を行いました。' },
  { published_on: '2025-08-09', content: '<span class="badge bg-success me-2">NEW</span>ログイン機能を追加しました。' }
])

# ゲストユーザーを検索し、なければ作成する
User.find_or_create_by!(email: "guest@example.com") do |user|
  user.name = "ゲストユーザー"
  # パスワードは不要ですが、deviseなどのgemを使う場合はダミーのパスワードを設定します。
  # 今回のOmniAuthのみの実装では、emailとnameだけで十分です。
end
