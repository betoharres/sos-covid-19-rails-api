class AddSoreThroatToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :sore_throat, :bool, default: false
  end
end
