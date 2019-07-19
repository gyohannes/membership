class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :membership_idcard, :confirm]

  # GET /people
  # GET /people.json
  def index
    @people = current_user.organization_unit.try(:sub_people) || []
  end

  def confirm
    @person.update(status: true)
    flash[:notice] = 'Member Successfully Confirmed'
    render action: 'show'
  end

  def membership_idcard
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Membership ID Card",
               disposition: 'attachment',
               encoding: 'utf8'
      end
    end
  end

  def members_paid
    @members_paid = current_user.organization_unit.try(:sub_people).joins(:payments).where('budget_year_id = ?', BudgetYear.active.try(:id))
  end

  def load_members_paid
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members_paid = @organization_unit.sub_people.joins(:payments).where('budget_year_id = ?', BudgetYear.active.try(:id))
    render partial: 'members_paid'
  end

  def members_not_paid
    @members_not_paid = current_user.organization_unit.try(:sub_people) - current_user.organization_unit.try(:sub_people).joins(:payments).where('budget_year_id = ?', BudgetYear.active.try(:id))
  end

  def load_members_not_paid
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members_not_paid = @organization_unit.sub_people - @organization_unit.sub_people.joins(:payments).where('budget_year_id = ?', BudgetYear.active.try(:id))
    render partial: 'members_not_paid'
  end

  def members_by_type
    members = current_user.organization_unit.sub_people.joins(:membership_type).group('membership_types.name').count
    render json: members
  end

  def members_by_membership_type_and_payment_status
    members = []
    ['Paid', 'Not Paid'].each do |c|
      members << {name: c, data: MembershipType.all.map{|mt| [mt.to_s, mt.members_by_status(current_user,c).count]} }
    end
    render json: members
  end

  def load_people
    @organization_unit  = OrganizationUnit.find(params[:node])
    @people = @organization_unit.sub_people
    render partial: 'people'
  end
  # GET /people/1
  # GET /people/1.json
  def show
    session[:return_to] = request.referer
  end

  # GET /people/new
  def new
    @professions = []
    if params[:facility]
      @facility = Facility.find(params[:facility])
      @organization_unit = @facility.organization_unit
    else
      @organization_unit = OrganizationUnit.find_by_id(params[:organization_unit])
    end
    @person = Person.new
    @person.organization_unit = @organization_unit unless @organization_unit.blank?
    @person.facility = @facility unless @facility.blank?
  end

  def load_professions
    profession_category = ProfessionCategory.find(params[:profession_category])
    @professions = profession_category.professions
    render partial: 'profession'
  end

  # GET /people/1/edit
  def edit
    @organization_unit = @person.organization_unit
    profession_category = @person.profession.profession_category rescue nil
    @professions = profession_category.professions rescue nil
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    profession_category = @person.profession.try(:profession_category)
    @professions = profession_category.try(:professions)
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    profession_category = @person.profession.profession_category rescue nil
    @professions = profession_category.professions rescue nil
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:profession_id, :gender, :date_of_birth, :photo, :user_id, :title, :membership_type_id, :job_title, :first_name, :middle_name, :last_name,
                                     :email, :phone_number, :kebelle, :house_number, :organization_unit_id, :facility_id, :id_number)
    end
end
