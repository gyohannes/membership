class TrainingMaterialsController < ApplicationController
  before_action :set_training_material, only: [:show, :edit, :update, :destroy]

  # GET /training_materials
  # GET /training_materials.json
  def index
    @training_materials = TrainingMaterial.all
  end

  # GET /training_materials/1
  # GET /training_materials/1.json
  def show
  end

  # GET /training_materials/new
  def new
    @training_material = TrainingMaterial.new
  end

  # GET /training_materials/1/edit
  def edit
    @training_title = @training_material.training_title
  end

  # POST /training_materials
  # POST /training_materials.json
  def create
    @training_material = TrainingMaterial.new(training_material_params)

    respond_to do |format|
      if @training_material.save
        format.html { redirect_to @training_material.training_title, notice: 'Training material was successfully created.' }
        format.json { render :show, status: :created, location: @training_material }
      else
        format.html { render :new }
        format.json { render json: @training_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_materials/1
  # PATCH/PUT /training_materials/1.json
  def update
    respond_to do |format|
      if @training_material.update(training_material_params)
        format.html { redirect_to @training_material.training_title, notice: 'Training material was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_material }
      else
        format.html { render :edit }
        format.json { render json: @training_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_materials/1
  # DELETE /training_materials/1.json
  def destroy
    training_title = @training_material.training_title
    @training_material.destroy
    respond_to do |format|
      format.html { redirect_to training_title, notice: 'Training material was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_material
      @training_material = TrainingMaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_material_params
      params.require(:training_material).permit(:training_title_id, :name, :attachment)
    end
end
