class AddResolvedToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :resolved, :boolean
  end
end
