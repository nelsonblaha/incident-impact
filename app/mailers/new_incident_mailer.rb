class NewIncidentMailer < ActionMailer::Base
  default from: "incidenttracker@uta.edu"
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  
  def new_incident_notify(incident)
    @incident = incident
    @id = incident.id
    @user = incident.user.netid
    @description = incident.description
    @impact = incident.impact_index
    subject = 'New IT Incident: ' + @id.to_s + ' created by ' + @user + ': ' + @description
    mail(to: 'robertl@uta.edu', subject: subject)
  end
end
