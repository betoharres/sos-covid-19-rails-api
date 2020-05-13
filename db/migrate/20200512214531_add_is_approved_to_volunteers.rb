class AddIsApprovedToVolunteers < ActiveRecord::Migration[6.0]
  def change
    add_column :volunteers, :is_approved, :string
  end
end
