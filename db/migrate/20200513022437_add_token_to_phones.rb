class AddTokenToPhones < ActiveRecord::Migration[6.0]
  def change
    add_column :phones, :token, :string
    add_index :phones, :token, unique: true
  end
end
