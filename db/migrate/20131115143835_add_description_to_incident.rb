class AddDescriptionToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :description, :string
  end
end
