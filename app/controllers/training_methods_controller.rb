class TrainingMethodsController < ApplicationController
  before_action :set_training_method, only: [:show, :edit, :update, :destroy]

  # GET /training_methods
  # GET /training_methods.json
  def index
    @training_methods = TrainingMethod.all
  end

  # GET /training_methods/1
  # GET /training_methods/1.json
  def show
  end

  # GET /training_methods/new
  def new
    @training_method = TrainingMethod.new
  end

  # GET /training_methods/1/edit
  def edit
  end

  # POST /training_methods
  # POST /training_methods.json
  def create
    @training_method = TrainingMethod.new(training_method_params)

    respond_to do |format|
      if @training_method.save
        format.html { redirect_to training_methods_path, notice: 'Training method was successfully created.' }
        format.json { render :show, status: :created, location: @training_method }
      else
        format.html { render :new }
        format.json { render json: @training_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_methods/1training_methods_url
  # PATCH/PUT /training_methods/1.json
  def update
    respond_to do |format|
      if @training_method.update(training_method_params)
        format.html { redirect_to training_methods_path, notice: 'Training method was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_method }
      else
        format.html { render :edit }
        format.json { render json: @training_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_methods/1
  # DELETE /training_methods/1.json
  def destroy
    @training_method.destroy
    respond_to do |format|
      format.html { redirect_to training_methods_url, notice: 'Training method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_method
      @training_method = TrainingMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_method_params
      params.require(:training_method).permit(:name, :description)
    end
end
