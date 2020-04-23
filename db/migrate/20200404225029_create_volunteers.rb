class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string   :name, null: false
      t.string   :email, null: false
      t.string   :password_digest, null: false
      t.string   :token, null: false
      t.string   :password_reset_token, null: false
      t.datetime :password_reset_at, null: false
      t.boolean  :is_email_verified, default: false
      t.string   :job_desire # WIP: onde quer atuar
      t.string   :job_experience # WIP: onde tem experiencia
      t.string   :identifier # numero do CRM CRN etc...
      t.string   :identifier_type # tipo de identificacao -> CRM CRN etc...
      t.string   :website # espaco para publicidade do voluntario
      t.references :phone, null: false, foreign_key: true

      t.timestamps
    end
    add_index :volunteers, :email, unique: true
    add_index :volunteers, :token, unique: true
    add_index :volunteers, :password_reset_token, unique: true
  end
end
