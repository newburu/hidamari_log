class CreateChangelogs < ActiveRecord::Migration[8.0]
  def change
    create_table :changelogs do |t|
      t.date :published_on
      t.text :content

      t.timestamps
    end
  end
end
