class CreateGoalOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_owners do |t|
      t.belongs_to :user, null: true, foreign_key: true
      t.belongs_to :group, null: true, foreign_key: true
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
