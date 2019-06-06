class ProgramAreasController < ApplicationController
  before_action :set_program_area, only: [:show, :edit, :update, :destroy]

  # GET /program_areas
  # GET /program_areas.json
  def index
    @program_areas = ProgramArea.all
  end

  # GET /program_areas/1
  # GET /program_areas/1.json
  def show
  end

  # GET /program_areas/new
  def new
    @program_area = ProgramArea.new
  end

  # GET /program_areas/1/edit
  def edit
  end

  # POST /program_areas
  # POST /program_areas.json
  def create
    @program_area = ProgramArea.new(program_area_params)

    respond_to do |format|
      if @program_area.save
        format.html { redirect_to program_areas_path, notice: 'Program area was successfully created.' }
        format.json { render :show, status: :created, location: @program_area }
      else
        format.html { render :new }
        format.json { render json: @program_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_areas/1
  # PATCH/PUT /program_areas/1.json
  def update
    respond_to do |format|
      if @program_area.update(program_area_params)
        format.html { redirect_to program_areas_path, notice: 'Program area was successfully updated.' }
        format.json { render :show, status: :ok, location: @program_area }
      else
        format.html { render :edit }
        format.json { render json: @program_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_areas/1
  # DELETE /program_areas/1.json
  def destroy
    @program_area.destroy
    respond_to do |format|
      format.html { redirect_to program_areas_url, notice: 'Program area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_area
      @program_area = ProgramArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_area_params
      params.require(:program_area).permit(:name, :description)
    end
end
