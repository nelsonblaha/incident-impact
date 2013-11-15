class Incident < ActiveRecord::Base
  belongs_to :user
  before_save :calculate_impact
  
  def calculate_impact
    self.impact_index = self.initial_service_rating +
                        self.service_impact
        
    if Time.now.saturday? || Time.now.sunday?
      self.time_impact = 2 if Time.now.hour > 9 && Time.now.hour < 18
    elsif Time.now.hour > 7 && Time.now.hour < 21
      self.time_impact = 3
    else
      self.time_impact = 1
    end

    ACADEMIC_CALENDAR_HOLIDAYS.each do |time|
      self.time_impact = 0 if Time.now.to_date == Time.utc(*time).to_date
    end
    ACADEMIC_CALENDAR_FINALS.each do |time|
      self.time_impact = 4 if Time.now.to_date == Time.utc(*time).to_date
    end
    self.impact_index += self.time_impact if self.time_impact
    self.impact_index += self.escalation_policy if self.escalation_policy
                        
  end
end
