class AddSickDaysToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :sick_days, :integer
  end
end
