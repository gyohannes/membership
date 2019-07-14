class ProfessionCategoriesController < ApplicationController
  before_action :set_profession_category, only: [:show, :edit, :update, :destroy]

  # GET /profession_categories
  # GET /profession_categories.json
  def index
    @profession_categories = ProfessionCategory.all
  end

  # GET /profession_categories/1
  # GET /profession_categories/1.json
  def show
  end

  # GET /profession_categories/new
  def new
    @profession_category = ProfessionCategory.new
  end

  # GET /profession_categories/1/edit
  def edit
  end

  # POST /profession_categories
  # POST /profession_categories.json
  def create
    @profession_category = ProfessionCategory.new(profession_category_params)

    respond_to do |format|
      if @profession_category.save
        format.html { redirect_to profession_categories_path, notice: 'Profession category was successfully created.' }
        format.json { render :show, status: :created, location: @profession_category }
      else
        format.html { render :new }
        format.json { render json: @profession_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profession_categories/1
  # PATCH/PUT /profession_categories/1.json
  def update
    respond_to do |format|
      if @profession_category.update(profession_category_params)
        format.html { redirect_to profession_categories_path, notice: 'Profession category was successfully updated.' }
        format.json { render :show, status: :ok, location: @profession_category }
      else
        format.html { render :edit }
        format.json { render json: @profession_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profession_categories/1
  # DELETE /profession_categories/1.json
  def destroy
    @profession_category.destroy
    respond_to do |format|
      format.html { redirect_to profession_categories_url, notice: 'Profession category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profession_category
      @profession_category = ProfessionCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profession_category_params
      params.require(:profession_category).permit(:name)
    end
end
