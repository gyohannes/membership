class OrganizationUnitsController < ApplicationController
  before_action :set_organization_unit, only: [:show, :edit, :update, :destroy]

  # GET /organization_units
  # GET /organization_units.json
  def index
    @organization_units = current_user.organization_unit == OrganizationUnit.top_organization_unit ? OrganizationUnit.all : current_user.organization_unit.sub_units || []
    @parent = true if @organization_units.blank?
  end

  def load_tree
    render json: OrganizationUnit.organization_tree(current_user)
  end

  def org_unit_facilities
    unless current_user.parent_org_unit.sub_organization_units.blank?
      health_workres = current_user.parent_org_unit.sub_organization_units.
          map{|x| [x.to_s => x.sub_people.count]}.flatten.inject({}){|hash, og| hash.merge!(og)}
    else
      health_workres = current_user.parent_org_unit.people.joins(:facility).group('facilities.name').count
    end
    render json: health_workres
  end

  def load_sub_units
    @parent  = OrganizationUnit.find(params[:node])
    @organization_units = @parent.sub_units
    render partial: 'organization_units'
  end
  # GET /organization_units/1
  # GET /organization_units/1.json
  def show
  end

  # GET /organization_units/new
  def new
    @parent = OrganizationUnit.find_by_id(params[:parent])
    @organization_unit = OrganizationUnit.new
    @organization_unit.parent_organization_unit = @parent
  end

  # GET /organization_units/1/edit
  def edit
    @parent = @organization_unit.parent_organization_unit
  end

  # POST /organization_units
  # POST /organization_units.json
  def create
    @organization_unit = OrganizationUnit.new(organization_unit_params)

    respond_to do |format|
      if @organization_unit.save
        format.html { redirect_to organization_units_path, notice: 'Organization unit was successfully created.' }
        format.json { render :show, status: :created, location: @organization_unit }
      else
        format.html { render :new }
        format.json { render json: @organization_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_units/1
  # PATCH/PUT /organization_units/1.json
  def update
    respond_to do |format|
      if @organization_unit.update(organization_unit_params)
        format.html { redirect_to organization_units_path, notice: 'Organization unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization_unit }
      else
        format.html { render :edit }
        format.json { render json: @organization_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_units/1
  # DELETE /organization_units/1.json
  def destroy
    @organization_unit.destroy
    respond_to do |format|
      format.html { redirect_to organization_units_url, notice: 'Organization unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_unit
      @organization_unit = OrganizationUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_unit_params
      params.require(:organization_unit).permit(:name, :short_name, :code, :url, :organization_type_id, :parent_organization_unit_id,
                                                :contact_person, :contact_phone, :contact_email, :latitude, :longitude, :description)
    end
end
