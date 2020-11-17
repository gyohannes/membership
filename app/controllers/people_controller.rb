require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :membership_idcard, :confirm]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @regions = OrganizationUnit.regions
    @zones = OrganizationUnit.zones
    @woredas = OrganizationUnit.woredas
  end

  def load_zones
    @zones = OrganizationUnit.zones.where(parent_organization_unit_id: params[:region])
    render partial: 'zone'
  end

  def load_woredas
    @woredas = OrganizationUnit.woredas.where(parent_organization_unit_id: params[:zone])
    render partial: 'woreda'
  end

  # GET /people
  # GET /people.json
  def index
    @people = current_user.organization_unit.try(:sub_people) || []
  end

  def upcoming_birthdays
    @people = Person.upcoming_birthdays
  end

  def upcoming_retirements
    @people = Person.upcoming_retirements
  end

  def id_cards
    @members = []
    member_ids = params[:members].delete_if{|e| e=='0'} rescue nil
    @members = member_ids.blank? ? [] : Person.find(member_ids)
    @members.each do |member|
      barcode = Barby::Code128.new(member.id_number)
      File.open("#{Rails.root}/public/barcodes/#{member.id_number}.png", 'wb'){|f|
        f.write barcode.to_png(:height => 20, :margin => 5)
      }
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "id_cards",
               disable_smart_shrinking: false,
               disposition: 'attachment',
               encoding: 'utf8'
      end
    end
  end

  def load_paid_members
    budget_year = BudgetYear.active
    organization_unit  = OrganizationUnit.find(params[:node])
    @members = budget_year.blank? ? [] : organization_unit.paid_members
    render partial: 'id_cards'
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
    @members_paid = current_user.organization_unit.paid_members
  end

  def load_members_paid
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members_paid = @organization_unit.paid_members
    render partial: 'members_paid'
  end

  def members_not_paid
    @members_not_paid = current_user.organization_unit.try(:sub_people) - current_user.organization_unit.paid_members
  end

  def load_members_not_paid
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members_not_paid = @organization_unit.sub_people - @organization_unit.paid_members
    render partial: 'members_not_paid'
  end

  def members_by_type
    members = current_user.organization_unit.paid_members.count
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
      @organization_unit = OrganizationUnit.find_by_id(params[:organization_unit])
    @person = Person.new
    @person.organization_unit = @organization_unit unless @organization_unit.blank?
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
      params.require(:person).permit(:first_name, :father_name, :grand_father_name, :sex, :date_of_birth, :photo,
                                     :nationality, :country, :membership_type_id, :email, :mobile_phone, :organization_unit_id, :pobox)
    end
end
