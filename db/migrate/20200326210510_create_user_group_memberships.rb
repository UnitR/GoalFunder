class CreateUserGroupMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :user_group_memberships do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.references :group, null: false, foreign_key: true, index: true
      t.string :status

      t.timestamps
    end
  end
end
