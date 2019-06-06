class BudgetYearsController < ApplicationController
  before_action :set_budget_year, only: [:show, :edit, :update, :destroy]

  # GET /budget_years
  # GET /budget_years.json
  def index
    @budget_years = BudgetYear.all
  end

  # GET /budget_years/1
  # GET /budget_years/1.json
  def show
  end

  # GET /budget_years/new
  def new
    @budget_year = BudgetYear.new
  end

  # GET /budget_years/1/edit
  def edit
  end

  # POST /budget_years
  # POST /budget_years.json
  def create
    @budget_year = BudgetYear.new(budget_year_params)

    respond_to do |format|
      if @budget_year.save
        format.html { redirect_to budget_years_path, notice: 'Budget year was successfully created.' }
        format.json { render :show, status: :created, location: @budget_year }
      else
        format.html { render :new }
        format.json { render json: @budget_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budget_years/1
  # PATCH/PUT /budget_years/1.json
  def update
    respond_to do |format|
      if @budget_year.update(budget_year_params)
        format.html { redirect_to budget_years_path, notice: 'Budget year was successfully updated.' }
        format.json { render :show, status: :ok, location: @budget_year }
      else
        format.html { render :edit }
        format.json { render json: @budget_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budget_years/1
  # DELETE /budget_years/1.json
  def destroy
    @budget_year.destroy
    respond_to do |format|
      format.html { redirect_to budget_years_url, notice: 'Budget year was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget_year
      @budget_year = BudgetYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_year_params
      params.require(:budget_year).permit(:name, :from, :to, :status)
    end
end
