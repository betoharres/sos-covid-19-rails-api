class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :token
      t.string :identifier
      t.string :identifier_type
      t.references :phone, null: false, foreign_key: true

      t.timestamps
    end
    add_index :volunteers, :email, unique: true
  end
end
