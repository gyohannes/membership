class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @regions = OrganizationUnit.regions
  end

  def load_zones
    @zones = OrganizationUnit.zones.where(parent_organization_unit_id: params[:region])
    render partial: 'zone'
  end

  def load_woredas
    @woredas = OrganizationUnit.woredas.where(parent_organization_unit_id: params[:zone])
    render partial: 'woreda'
  end

  # GET /institutions
  # GET /institutions.json
  def index
    @institutions = Institution.all
  end

  # GET /institutions/1
  # GET /institutions/1.json
  def show
  end

  # GET /institutions/new
  def new
    @institution = Institution.new
    @institution.member_id = params[:member]
  end

  # GET /institutions/1/edit
  def edit
    @zones = OrganizationUnit.zones.where(parent_organization_unit_id: @institution.region.id)
    @woredas = OrganizationUnit.zones.where(parent_organization_unit_id: @institution.zone.id)
  end

  # POST /institutions
  # POST /institutions.json
  def create
    @institution = Institution.new(institution_params)
    @zones = OrganizationUnit.zones.where(parent_organization_unit_id: @institution.region.try(:id))
    @woredas = OrganizationUnit.zones.where(parent_organization_unit_id: @institution.zone.try(:id))
    respond_to do |format|
      if @institution.save
        format.html { redirect_to @institution.member, notice: 'Institution was successfully created.' }
        format.json { render :show, status: :created, location: @institution }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /institutions/1
  # PATCH/PUT /institutions/1.json
  def update
    respond_to do |format|
      if @institution.update(institution_params)
        format.html { redirect_to @institution.member, notice: 'Institution was successfully updated.' }
        format.json { render :show, status: :ok, location: @institution }
      else
        @zones = OrganizationUnit.zones.where(parent_organization_unit_id: @institution.region.id)
        @woredas = OrganizationUnit.zones.where(parent_organization_unit_id: @institution.zone.id)
        format.html { render :edit }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /institutions/1
  # DELETE /institutions/1.json
  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to institutions_url, notice: 'Institution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:member_id, :name_of_organization, :establishment_year, :organization_unit_id,
                                          :kebele, :city, :telephone_number, :email, :website, :pobox, :fax, :contact_name,
                                          :contact_title, :contact_telephone_number, :type_of_organization, :major_objectives,
                                          :logo, :certificate)
    end
end
