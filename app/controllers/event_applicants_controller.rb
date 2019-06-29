class EventApplicantsController < ApplicationController
  before_action :set_event_applicant, only: [:show, :edit, :update, :destroy]

  # GET /event_applicants
  # GET /event_applicants.json
  def index
    @event_applicants = EventApplicant.all
  end

  # GET /event_applicants/1
  # GET /event_applicants/1.json
  def show
  end

  # GET /event_applicants/new
  def new
    @event_applicant = EventApplicant.new
  end

  # GET /event_applicants/1/edit
  def edit
  end

  # POST /event_applicants
  # POST /event_applicants.json
  def create
    @event_applicant = EventApplicant.new(event_applicant_params)

    respond_to do |format|
      if @event_applicant.save
        format.html { redirect_to @event_applicant, notice: 'Event applicant was successfully created.' }
        format.json { render :show, status: :created, location: @event_applicant }
      else
        format.html { render :new }
        format.json { render json: @event_applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_applicants/1
  # PATCH/PUT /event_applicants/1.json
  def update
    respond_to do |format|
      if @event_applicant.update(event_applicant_params)
        format.html { redirect_to @event_applicant, notice: 'Event applicant was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_applicant }
      else
        format.html { render :edit }
        format.json { render json: @event_applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_applicants/1
  # DELETE /event_applicants/1.json
  def destroy
    @event_applicant.destroy
    respond_to do |format|
      format.html { redirect_to event_applicants_url, notice: 'Event applicant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_applicant
      @event_applicant = EventApplicant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_applicant_params
      params.require(:event_applicant).permit(:person_id, :event_id, :status)
    end
end
