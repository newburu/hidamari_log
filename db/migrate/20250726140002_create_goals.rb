class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.date :start_time

      t.timestamps
    end
  end
end
