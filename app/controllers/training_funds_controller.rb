class TrainingFundsController < ApplicationController
  before_action :set_training_fund, only: [:show, :edit, :update, :destroy]

  def funding_by_area
    render json: @institution.training_funds.joins(:training=>[:training_title=>:program_area]).
        group('program_areas.name').sum('amount')
  end

  # GET /training_funds
  # GET /training_funds.json
  def index
    @training_funds = TrainingFund.all
  end

  # GET /training_funds/1
  # GET /training_funds/1.json
  def show
  end

  # GET /training_funds/new
  def new
    @training_fund = TrainingFund.new
    @training_fund.training_id = params[:training]
  end

  # GET /training_funds/1/edit
  def edit
  end

  # POST /training_funds
  # POST /training_funds.json
  def create
    @training_fund = TrainingFund.new(training_fund_params)

    respond_to do |format|
      if @training_fund.save
        format.html { redirect_to @training_fund.training, notice: 'Training fund was successfully added.' }
        format.json { render :show, status: :created, location: @training_fund }
      else
        format.html { render :new }
        format.json { render json: @training_fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_funds/1
  # PATCH/PUT /training_funds/1.json
  def update
    respond_to do |format|
      if @training_fund.update(training_fund_params)
        format.html { redirect_to @training_fund.training, notice: 'Training fund was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_fund }
      else
        format.html { render :edit }
        format.json { render json: @training_fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_funds/1
  # DELETE /training_funds/1.json
  def destroy
    @training_fund.destroy
    respond_to do |format|
      format.html { redirect_to training_funds_url, notice: 'Training fund was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_fund
      @training_fund = TrainingFund.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_fund_params
      params.require(:training_fund).permit(:training_id, :institution_id, :amount)
    end
end
