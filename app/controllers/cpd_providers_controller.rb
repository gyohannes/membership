class CpdProvidersController < ApplicationController
  before_action :set_cpd_provider, only: [:show, :edit, :update, :destroy, :accept_or_reject]

  # GET /cpd_providers
  # GET /cpd_providers.json
  def index
    @cpd_providers = CpdProvider.all
  end

  def accept_or_reject
    @cpd_provider.update_attribute('status', params[:status])
    flash[:notice] = "CPD provider successfully #{params[:status]}"
    render 'show'
  end

  # GET /cpd_providers/1
  # GET /cpd_providers/1.json
  def show
  end

  # GET /cpd_providers/new
  def new
    @cpd_provider = CpdProvider.new
  end

  # GET /cpd_providers/1/edit
  def edit
  end

  # POST /cpd_providers
  # POST /cpd_providers.json
  def create
    @cpd_provider = CpdProvider.new(cpd_provider_params)

    respond_to do |format|
      if @cpd_provider.save
        format.html { redirect_to @cpd_provider, notice: 'Cpd provider was successfully created.' }
        format.json { render :show, status: :created, location: @cpd_provider }
      else
        format.html { render :new }
        format.json { render json: @cpd_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpd_providers/1
  # PATCH/PUT /cpd_providers/1.json
  def update
    respond_to do |format|
      if @cpd_provider.update(cpd_provider_params)
        format.html { redirect_to @cpd_provider, notice: 'Cpd provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpd_provider }
      else
        format.html { render :edit }
        format.json { render json: @cpd_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpd_providers/1
  # DELETE /cpd_providers/1.json
  def destroy
    @cpd_provider.destroy
    respond_to do |format|
      format.html { redirect_to cpd_providers_url, notice: 'Cpd provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpd_provider
      @cpd_provider = CpdProvider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpd_provider_params
      params.require(:cpd_provider).permit(:user_id, :organization_category, :type_of_organization, :name_of_organization,
                                           :availability_of_office, :training_hall, :syndicate_room,
                                           :availability_of_shelf, :availability_of_electronic_database,
                                           :toilet_service, :running_water_available, :place_for_coffee_break, :website_availability,
                                           :internet_connection, :accredited_activities_on_website, :how_frequently_updated,
                                           :administration_assistant, :designated_cpd_director, :cpd_director_name,
                                           :cpd_director_telephone_number, :cpd_director_email, :training_officer, :it_officer,
                                           :organization_unit_id, :city, :sub_city_or_zone, :woreda, :kebele, :house_number,
                                           :telephone_number, :street, :email, :pobox, :applied_to_another_accreditor, :name_of_accreditor,
                                           :outcome_and_reason, :status, telephone_fax_email: [], computer_printer_lcd_photo_copy: [])
    end
end
