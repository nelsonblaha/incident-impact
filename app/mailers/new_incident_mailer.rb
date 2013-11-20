class NewIncidentMailer < ActionMailer::Base
  default from: "incidenttracker@uta.edu"
  Rails.application.routes.default_url_options[:host] = 'http://hdapps-1.uta.edu/incident-tracker'
  
  def new_incident_notify(incident)
    @incident = incident
    @id = incident.id
    @user = incident.user.netid
    @description = incident.description
    @impact = incident.impact_index
    subject = 'New IT Incident: ' + @id.to_s + ' created by ' + @user + ': ' + @description
    #mail(to: 'cruz@uta.edu', subject: subject)
    mail(to: 'robertl@uta.edu', subject: subject)
  end
end
