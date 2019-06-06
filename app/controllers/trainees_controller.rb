class TraineesController < ApplicationController
  before_action :set_trainee, only: [:show, :edit, :update, :destroy]

  def institution_trainees_by_area
    trainees = []
    ['Basic', 'Refreshment', 'TOT'].each do |t|
      trainees << {name: t, data: ProgramArea.all.map{|p| [p.to_s, p.institution_trainees_by_type(current_user.institution, t)]} }
    end
    render json: trainees

  end

  def institution_trainees_by_region
    trainees = {}
    (current_user.parent_org_unit.sub_units).each do |ou|
      trainees["#{ou.to_s}"] = @institution.institution_trainees(ou,nil,nil).count
      end
    render json: trainees
  end

  def org_unit_trainees_by_area
    trainees = []
      ['Basic', 'Refreshment', 'TOT'].each do |t|
      trainees << {name: t, data: ProgramArea.all.map{|p| [p.to_s, p.trainees_by_type(current_user.organization_unit, t)]} }
    end
    render json: trainees
  end

  def org_unit_trainees_by_year
    trainees = []
    ['Basic', 'Refreshment', 'TOT'].each do |t|
      trainees << {name: t, data: BudgetYear.all.map{|by| [by.to_s, by.trainees_by_year(current_user.organization_unit, t)]} }
    end
    render json: trainees
  end

  def institution_trainees_by_year
    trainees = []
    ['Basic', 'Refreshment', 'TOT'].each do |t|
      trainees << {name: t, data: BudgetYear.all.map{|by| [by.to_s, by.institution_trainees_by_year(current_user.institution, t)]} }
    end
    render json: trainees
  end

  def org_unit_trainees_by_category
    trainees = []
    ['In-Service', 'Pre-Service'].each do |c|
      trainees << {name: c, data: ProgramArea.all.map{|pa| [pa.to_s, pa.trainees_by_category(current_user.organization_unit, c)]} }
    end
    render json: trainees
  end

  # GET /trainees
  # GET /trainees.json
  def index
    if !params[:training].blank?
      @training = Training.find(params[:training])
      @trainees = @training.trainees
    elsif !current_user.organization_unit.blank?
      @trainees = Trainee.joins(:person).where('people.id in (?)', current_user.organization_unit.sub_people.pluck(:id))
    elsif !@institution.blank?
      @trainees = @institution.trainees
    else
      @trainees= []
    end
  end

  def load_trainees
    @training = Training.find(params[:training])
    @organization_unit  = OrganizationUnit.find(params[:node])
    @people = @organization_unit.sub_people
    @trainees = []
    @people.each do |p|
      @trainees << Trainee.new(training_id: @training.id, person_id: p.id )
    end
    render partial: 'trainees'
  end

  # GET /trainees/1
  # GET /trainees/1.json
  def show
  end

  # GET /trainees/new
  def new
    @trainees = []
    @training = Training.find(params[:training])
  end

  # GET /trainees/1/edit
  def edit
    @training = @trainee.training
    @person = @trainee.person
  end

  # POST /trainees
  # POST /trainees.json
  def create
    @training = Training.find(params[:training])
    remaining_trainees = @training.remaining_trainees(current_user.parent_org_unit)
    selected_trainees_count = params["trainees"].select{|t| t[:status] == 'true'}.count
    if selected_trainees_count > remaining_trainees
      flash[:alert] = "Too many trainees selected. You can only add maximum of #{remaining_trainees} trainees"
      render :new
    else
      params["trainees"].each do |trainee|
        if trainee["status"] == "true"
          trainee[:status] = Trainee::PENDING
          Trainee.create(trainee_params(trainee))
        end
      end
      if selected_trainees_count > 0
        flash[:notice] = "#{selected_trainees_count} trainees added successfully"
      else
        flash[:alert] = "No trainees are added"
      end
      redirect_to @training
    end
  end

  # PATCH/PUT /trainees/1
  # PATCH/PUT /trainees/1.json
  def update
    respond_to do |format|
      if @trainee.update_attributes(trainee_params(nil))
        format.html { redirect_to(@trainee, :notice => 'Trainee was successfully updated.') }
        format.json { respond_with_bip(@trainee) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@trainee) }
      end
    end
  end

  # DELETE /trainees/1
  # DELETE /trainees/1.json
  def destroy
    @trainee.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trainee
      @trainee = Trainee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trainee_params(my_params)
      my_params.blank? ?  params.require(:trainee).permit(:training_id, :person_id, :status, :pre_training_score, :post_training_score, :trainer_feedback, :training_interest) : my_params.permit(:training_id, :person_id, :status, :pre_training_score, :post_training_score, :trainer_feedback, :training_interest)
    end

end
