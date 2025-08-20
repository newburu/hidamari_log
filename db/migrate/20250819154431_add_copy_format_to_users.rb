class AddCopyFormatToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :copy_format, :text
  end
end
