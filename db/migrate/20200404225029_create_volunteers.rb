class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :token
      t.string :identifier
      t.string :identifier_type
      t.references :phone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
