class IncidentsController < ApplicationController
  before_action :set_incident, only: [ :show, :edit, :update, :destroy ]
  before_action :escalation_policy, only: [ :edit, :update ]
  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.all
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user
        
    respond_to do |format|
      if @incident.save
        NewIncidentMailer.new_incident_notify(@incident).deliver
        format.html { redirect_to '/incidents', notice: 'Incident was successfully created.' }
        format.json { render action: '/incidents', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to '/incidents', notice: 'Incident was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:impact_index, :initial_service_rating, :service_impact, :time_impact, :escalation_policy, :user_id, :description, :resolved)
    end
    
    def escalation_policy
      if !@incident.resolved?
        if @incident.initial_service_rating == 0
          @incident.escalation_policy = (( Time.now - @incident.created_at) / 5.hours ).round
        elsif  @incident.initial_service_rating >= 0 
          @incident.escalation_policy = (( Time.now - @incident.created_at) / 1.hours ).round
        else
          true
        end
      end
    end
end
