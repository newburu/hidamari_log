class AddCopyFormatToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :copy_format, :text, default: "今日のGood&Newは、\n{Good&New}\n\n目標は、\n{目標}"
  end
end
