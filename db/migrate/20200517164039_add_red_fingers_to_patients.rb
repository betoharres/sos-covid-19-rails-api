class AddRedFingersToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :red_fingers, :bool, default: false
  end
end
