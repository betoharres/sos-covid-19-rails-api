class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string :number, null: false
      t.string :sms_code
      t.boolean :is_verified, default: false

      t.timestamps
    end
    add_index :phones, :number, unique: true
  end
end
