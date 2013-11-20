class NewIncidentMailer < ActionMailer::Base
  default from: "incidenttracker@uta.edu"
  Rails.application.routes.default_url_options[:host] = 'http://hdapps-1.uta.edu/incident-tracker'
  
  def new_incident_notify(incident)
    if user = incident.user
      @incident = incident
      @id = incident.id
      @netid = user.netid
      @description = incident.description
      @impact = incident.impact_index
      subject = 'New IT Incident: ' + @id.to_s + ' created by ' + @netid + ': ' + @description
      #mail(to: 'cruz@uta.edu', subject: subject)
      mail(to: 'robertl@uta.edu', subject: subject)
    end
  end
end
