class PaymentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
      if params[:member]
        @members = [Member.find(params[:member])]
      else
        @members = current_user.organization_unit.try(:sub_members)
      end
  end
  # GET /payments
  # GET /payments.json
  def index
    if params['year']
      budget_year = BudgetYear.find(params['year'])
      @payments = current_user.organization_unit.sub_payments
    else
      @payments = Payment.all
    end
  end

  def load_payments
    @organization_unit  = OrganizationUnit.find(params[:node])
    @payments = @organization_unit.sub_payments
    render partial: 'payments'
  end


  def member_fees
    @unpaid_fees = []
    @type = params[:type]

    if @type == 'Unpaid' || @type == 'All'
      @unpaid_fees = current_user.member.unpaid_fees
    end
    @payments = current_user.member.payments
  end

  def confirm
    @payment.update(status: true)
    flash[:notice] = 'Payment was successfully confirmed.'
    redirect_to action: 'index'
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @payment.member_id = params[:member]
    @payment.budget_year_id = params[:year]
    session[:return_to] = request.referer
  end

  def load_amount
    member = Member.find_by(id: params[:member])
    budget_year = BudgetYear.find_by(id: params[:budget_year])
    @amount = budget_year.payment_amount(member.membership_type_id)
    render partial: 'amount'
  end

  # GET /payments/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to session.delete(:return_to), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:member_id, :attachment, :payment_method, :amount, :budget_year_id, :remark, :status)
    end
end
