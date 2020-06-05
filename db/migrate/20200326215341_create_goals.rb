class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.float :target
      t.text :keywords, array: true, default: []

      t.timestamps
    end
  end
end
