# app/forms/entry_form.rb
class EntryForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # フォームで受け付ける属性を定義
  attribute :content, :string
  attribute :title, :string
  attribute :start_time, :datetime
  attribute :user_id, :integer
  attribute :event_id, :integer
  attribute :goal_id, :integer

  # バリデーション
  validates :content, presence: true

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

  def update
    return false unless valid?

    ActiveRecord::Base.transaction do
      user = User.find(user_id)
      event = user.events.find(event_id)
      event.update!(content: content)

      goal = user.goals.find_by(id: goal_id)
      if title.present?
        if goal.present?
          goal.update!(title: title)
        else
          user.goals.create!(title: title, start_time: start_time)
        end
      elsif goal.present?
        goal.destroy!
      end
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.each do |error|
      errors.add(error.attribute, error.message)
    end
    false
  end
end
