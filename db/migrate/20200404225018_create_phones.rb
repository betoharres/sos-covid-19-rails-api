class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string :number
      t.boolean :is_verified

      t.timestamps
    end
    add_index :phones, :number, unique: true
  end
end
