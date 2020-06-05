class CreateOrganisationDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :organisation_details do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :address
      t.string :telephone
      t.string :website
      t.string :name

      t.timestamps
    end
  end
end
