# app/forms/entry_form.rb
class EntryForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # フォームで受け付ける属性を定義
  attribute :content, :string
  attribute :title, :string
  attribute :start_time, :datetime
  attribute :user_id, :integer

  # バリデーション
  validates :content, presence: true
  validate :content_length

  def save
    # バリデーションに失敗したら false を返す
    return false unless valid?

    # データベースへの保存をトランザクションで囲む
    ActiveRecord::Base.transaction do
      user = User.find(user_id)

      # Good & New (Event) の作成
      user.events.create!(
        content: content,
        start_time: start_time
      )

      # Goal が入力されていれば作成する
      if title.present?
        user.goals.create!(
          title: title,
          start_time: start_time
        )
      end
    end
    true # 成功したら true を返す
  rescue ActiveRecord::RecordInvalid => e
    # 保存に失敗した場合、エラー情報をフォームオブジェクトにコピーする
    e.record.errors.each do |error|
      errors.add(error.attribute, error.message)
    end
    false
  end

  private

  def content_length
    return if content.blank?
    return unless user_id

    user = User.find(user_id)
    # The `try` is important because the migration has not run yet.
    limit = user.try(:good_new_character_limit) || 250

    if content.length > limit
      errors.add(:content, "は\#{limit}文字以内で入力してください")
    end
  end
end
