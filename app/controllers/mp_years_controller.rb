class MpYearsController < ApplicationController
  before_action :set_mp_year, only: [:show, :edit, :update, :destroy]

  # GET /mp_years
  # GET /mp_years.json
  def index
    @mp_years = MpYear.all
  end

  # GET /mp_years/1
  # GET /mp_years/1.json
  def show
  end

  # GET /mp_years/new
  def new
    @mp_year = MpYear.new
  end

  # GET /mp_years/1/edit
  def edit
  end

  # POST /mp_years
  # POST /mp_years.json
  def create
    @mp_year = MpYear.new(mp_year_params)

    respond_to do |format|
      if @mp_year.save
        format.html { redirect_to mp_years_path, notice: 'Mp year was successfully created.' }
        format.json { render :show, status: :created, location: @mp_year }
      else
        format.html { render :new }
        format.json { render json: @mp_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mp_years/1
  # PATCH/PUT /mp_years/1.json
  def update
    respond_to do |format|
      if @mp_year.update(mp_year_params)
        format.html { redirect_to mp_years_path, notice: 'Mp year was successfully updated.' }
        format.json { render :show, status: :ok, location: @mp_year }
      else
        format.html { render :edit }
        format.json { render json: @mp_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mp_years/1
  # DELETE /mp_years/1.json
  def destroy
    @mp_year.destroy
    respond_to do |format|
      format.html { redirect_to mp_years_url, notice: 'Mp year was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mp_year
      @mp_year = MpYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mp_year_params
      params.require(:mp_year).permit(:name, :from, :to, :status, :description)
    end
end
