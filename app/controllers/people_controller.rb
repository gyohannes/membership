class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    parent_org_unit = current_user.super_admin? ? OrganizationUnit.top_organization_unit :
                          current_user.organization_unit
    @people = parent_org_unit.try(:sub_people) || []
  end

  def load_people
    @organization_unit  = OrganizationUnit.find(params[:node])
    @people = @organization_unit.sub_people
    render partial: 'people'
  end
  # GET /people/1
  # GET /people/1.json
  def show
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
    profession_category = @person.profession.profession_category
    @professions = profession_category.professions
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    profession_category = @person.profession.try(:profession_category)
    @professions = profession_category.try(:professions)
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
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
    profession_category = @person.profession.profession_category
    @professions = profession_category.professions
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
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
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
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
                                     :email, :phone_number, :address, :country, :organization_unit_id, :institution_id, :facility_id)
    end
end
