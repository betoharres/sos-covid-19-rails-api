class AddAasmStateToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :aasm_state, :string
  end
end
