class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.jsonb :image_data
      t.belongs_to :user, null: true, foreign_key: true
      t.belongs_to :group, null: true, foreign_key: true
      t.belongs_to :goal, null: true, foreign_key: true

      t.timestamps
    end
  end
end
