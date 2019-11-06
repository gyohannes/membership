class SupportRequestsController < ApplicationController
  layout 'messaging'
  before_action :set_support_request, only: [:show, :edit, :update, :destroy]

  # GET /support_requests
  # GET /support_requests.json
  def index
    @type = params[:type]
    if @type == 'sent'
    @support_requests = current_user.sent_requests
    else
      @support_requests = current_user.incoming_requests
    end
  end

  # GET /support_requests/1
  # GET /support_requests/1.json
  def show
    @support_request.update(status: true) unless @support_request.sender.to_i == current_user.id
  end

  # GET /support_requests/new
  def new
    parent_request = SupportRequest.find_by(id: params[:support] )
    @support_request = SupportRequest.new
    @support_request.parent_request_id = parent_request.id unless parent_request.blank?
    @support_request.receiver = parent_request.sender unless parent_request.blank?
  end

  # GET /support_requests/1/edit
  def edit
  end

  # POST /support_requests
  # POST /support_requests.json
  def create
    @support_request = SupportRequest.new(support_request_params)

    respond_to do |format|
      if @support_request.save
        format.html { redirect_to @support_request, notice: 'Support request was successfully created.' }
        format.json { render :show, status: :created, location: @support_request }
      else
        format.html { render :new }
        format.json { render json: @support_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /support_requests/1
  # PATCH/PUT /support_requests/1.json
  def update
    respond_to do |format|
      if @support_request.update(support_request_params)
        format.html { redirect_to @support_request, notice: 'Support request was successfully updated.' }
        format.json { render :show, status: :ok, location: @support_request }
      else
        format.html { render :edit }
        format.json { render json: @support_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /support_requests/1
  # DELETE /support_requests/1.json
  def destroy
    @support_request.destroy
    respond_to do |format|
      format.html { redirect_to support_requests_url, notice: 'Support request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_support_request
      @support_request = SupportRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def support_request_params
      params.require(:support_request).permit(:sender, :receiver, :parent_request_id, :subject, :message)
    end
end
