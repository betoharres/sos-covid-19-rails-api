class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.float      :latitude, null: false
      t.float      :longitude, null: false
      t.integer    :name
      t.integer    :age
      t.integer    :weight
      t.boolean    :fever, default: false
      t.boolean    :tired, default: false
      t.boolean    :headache, default: false
      t.boolean    :cough, default: false
      t.boolean    :short_breath, default: false
      t.boolean    :diarrhea, default: false
      t.boolean    :hyposmia, default: false
      t.boolean    :hypogeusia, default: false
      t.references :phone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
