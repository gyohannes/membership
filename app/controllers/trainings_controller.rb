class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy, :cancel, :undo_cancel]

  # GET /trainings
  # GET /trainings.json
  def index
    type = params[:type]
    @trainings = Training.load_trainings(current_user,type).uniq
  end
  # GET /trainings/1
  # GET /trainings/1.json
  def show
    @organization_unit = current_user.organization_unit || OrganizationUnit.top_organization_unit
    @trainers = Person.all
    @trainee_distributions = []
    @organization_unit.sub_organization_units.each do |sub_unit|
      @trainee_distributions << TraineeDistribution.new(training_id: @training.id, organization_unit_id: sub_unit.id, number_of_trainees: sub_unit.trainee_distribution(@training.id).try(:number_of_trainees))
    end
  end

  def load_distribution
    @training = Training.find(params[:training])
    @organization_unit  = OrganizationUnit.find(params[:node])
    @trainee_distributions = []
    @organization_unit.sub_organization_units.each do |sub_unit|
      @trainee_distributions << TraineeDistribution.new(training_id: @training.id, organization_unit_id: sub_unit.id, number_of_trainees: sub_unit.trainee_distribution(@training.id).try(:number_of_trainees))
    end
    render partial: 'trainee_distributions'
  end


  # GET /trainings/new
  def new
    @training = Training.new
    @training.training_title_id = params[:training_title]
    @institutions = !@institution.blank? ? [@institution] : Institution.all
  end

  # GET /trainings/1/edit
  def edit
    @institutions = !@institution.blank? ? [@institution] : Institution.all
  end

  def cancel
    @training.update(status: Training::CANCELED)
    redirect_to @training, notice: "Training Successfully Canceled"
  end

  def undo_cancel
    @training.update(status: nil)
    redirect_to @training, notice: "Training Successfully Re-enabled"
  end
  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.new(training_params)

    respond_to do |format|
      if @training.save
        format.html { redirect_to @training, notice: 'Training was successfully created.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to @training, notice: 'Training was successfully updated.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:category,:description,:training_title_id, :training_type, :start_time, :end_time,
                                       :organization_unit_id,:institution_id, :location, :budget_year_id)
    end
end
