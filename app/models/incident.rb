class Incident < ActiveRecord::Base
  belongs_to :user
  before_save :calculate_impact
  
  def calculate_impact
    self.impact_index = self.initial_service_rating +
                        self.service_impact
    # Time impact and escalation policy are currently added 
    # to the index conditionally until I complete implementation.
    
    self.impact_index += self.time_impact if self.time_impact
    self.impact_index += self.escalation_policy if self.escalation_policy
                        
  end
end
