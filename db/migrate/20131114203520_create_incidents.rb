class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.integer :impact_index
      t.integer :initial_service_rating
      t.integer :service_impact
      t.integer :time_impact
      t.integer :escalation_policy
      t.references :user, index: true

      t.timestamps
    end
  end
end
