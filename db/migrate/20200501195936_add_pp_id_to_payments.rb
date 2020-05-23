class AddPpIdToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :pp_id, :string
  end
end
