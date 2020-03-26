class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.boolean :is_organisation, index: true

      t.timestamps
    end
  end
end
