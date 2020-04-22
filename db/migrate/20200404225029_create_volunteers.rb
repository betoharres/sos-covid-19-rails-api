class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :job_desire, null: false # onde quer atuar
      t.string :job_experience, null: false # onde tem experiencia
      t.string :token
      t.string :identifier # numero do CRM CRN etc...
      t.string :identifier_type # tipo de identificacao -> CRM CRN etc...
      t.references :phone, null: false, foreign_key: true

      t.timestamps
    end
    add_index :volunteers, :email, unique: true
  end
end
