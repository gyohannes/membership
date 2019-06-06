class MpAmountSettingsController < ApplicationController
  before_action :set_mp_amount_setting, only: [:show, :edit, :update, :destroy]

  # GET /mp_amount_settings
  # GET /mp_amount_settings.json
  def index
    @mp_amount_settings = MpAmountSetting.all
  end

  # GET /mp_amount_settings/1
  # GET /mp_amount_settings/1.json
  def show
  end

  # GET /mp_amount_settings/new
  def new
    @mp_amount_setting = MpAmountSetting.new
  end

  # GET /mp_amount_settings/1/edit
  def edit
  end

  # POST /mp_amount_settings
  # POST /mp_amount_settings.json
  def create
    @mp_amount_setting = MpAmountSetting.new(mp_amount_setting_params)

    respond_to do |format|
      if @mp_amount_setting.save
        format.html { redirect_to @mp_amount_setting, notice: 'Mp amount setting was successfully created.' }
        format.json { render :show, status: :created, location: @mp_amount_setting }
      else
        format.html { render :new }
        format.json { render json: @mp_amount_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mp_amount_settings/1
  # PATCH/PUT /mp_amount_settings/1.json
  def update
    respond_to do |format|
      if @mp_amount_setting.update(mp_amount_setting_params)
        format.html { redirect_to @mp_amount_setting, notice: 'Mp amount setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @mp_amount_setting }
      else
        format.html { render :edit }
        format.json { render json: @mp_amount_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mp_amount_settings/1
  # DELETE /mp_amount_settings/1.json
  def destroy
    @mp_amount_setting.destroy
    respond_to do |format|
      format.html { redirect_to mp_amount_settings_url, notice: 'Mp amount setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mp_amount_setting
      @mp_amount_setting = MpAmountSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mp_amount_setting_params
      params.require(:mp_amount_setting).permit(:name, :mp_year_id, :membership_type_id, :amount, :description)
    end
end
