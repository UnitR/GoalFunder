class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :goal, null: false, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
