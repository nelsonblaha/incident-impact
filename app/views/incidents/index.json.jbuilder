json.array!(@incidents) do |incident|
  json.extract! incident, :impact_index, :initial_service_rating, :service_impact, :time_impact, :escalation_policy, :user_id
  json.url incident_url(incident, format: :json)
end
