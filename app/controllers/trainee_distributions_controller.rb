class TraineeDistributionsController < ApplicationController
  before_action :set_trainee_distribution, only: [:show, :edit, :update, :destroy]
  before_action :load_org_units

  def load_org_units
    if current_user.organization_unit
      @org_units = current_user.parent_org_unit.sub_organization_units
    else
      @org_units = OrganizationUnit.all
    end
  end

  # GET /trainee_distributions
  # GET /trainee_distributions.json
  def index
    @training = Training.find(params[:training])
    @trainee_distributions = @training.trainee_distributions
  end

  # GET /trainee_distributions/1
  # GET /trainee_distributions/1.json
  def show
  end

  # GET /trainee_distributions/new
  def new
    @trainee_distribution = TraineeDistribution.new
    @trainee_distribution.training_id = params[:training]
  end

  # GET /trainee_distributions/1/edit
  def edit
  end

  # POST /trainee_distributions
  # POST /trainee_distributions.json
  def create
    @training = Training.find(params[:training])
    max_number_of_trainees = @training.max_possible_trainees(current_user.parent_org_unit)
    trainees = params["distributions"].select{|t| !t['number_of_trainees'].blank? }
    total_distribution = trainees.collect{|t| t['number_of_trainees'].to_i}.sum
    if total_distribution > max_number_of_trainees
      flash[:alert] = "The sum should not exceed the possible number of trainees which is #{max_number_of_trainees}"
      redirect_to @training
    else
      params["distributions"].each do |trainee_distribution|
        unless trainee_distribution["number_of_trainees"].blank?
          org_unit = OrganizationUnit.find(trainee_distribution['organization_unit_id'])
          unless org_unit.trainee_distribution(@training.id).blank?
            org_unit.trainee_distribution(@training.id).update(trainee_distribution_params(trainee_distribution))
          else
            TraineeDistribution.create(trainee_distribution_params(trainee_distribution))
          end
        end
      end
      unless trainees.blank?
        flash[:notice] = "Successfully assigned"
      else
        flash[:alert] = "No assignment added"
      end
      redirect_to @training
    end
  end

  # PATCH/PUT /trainee_distributions/1
  # PATCH/PUT /trainee_distributions/1.json
  def update
  end

  # DELETE /trainee_distributions/1
  # DELETE /trainee_distributions/1.json
  def destroy
    @trainee_distribution.destroy
    respond_to do |format|
      format.html { redirect_to trainee_distributions_url, notice: 'Trainee distribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trainee_distribution
      @trainee_distribution = TraineeDistribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trainee_distribution_params(my_params)
      my_params.permit(:training_id, :organization_unit_id, :number_of_trainees)
    end
end
