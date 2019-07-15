class AssociationDetailsController < ApplicationController
  before_action :set_association_detail, only: [:show, :edit, :update, :destroy]

  # GET /association_details
  # GET /association_details.json
  def index
    @association_details = AssociationDetail.all
  end

  # GET /association_details/1
  # GET /association_details/1.json
  def show
    @current_board_term = BoardMembersTerm.active
    @presidents = BoardMember.joins(:board_members_term).where('role = ?', Constants::PRESIDENT).order('board_members_terms.from DESC')
  end

  # GET /association_details/new
  def new
    @association_detail = AssociationDetail.new
  end

  # GET /association_details/1/edit
  def edit
  end

  # POST /association_details
  # POST /association_details.json
  def create
    @association_detail = AssociationDetail.new(association_detail_params)

    respond_to do |format|
      if @association_detail.save
        format.html { redirect_to @association_detail, notice: 'Association detail was successfully created.' }
        format.json { render :show, status: :created, location: @association_detail }
      else
        format.html { render :new }
        format.json { render json: @association_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /association_details/1
  # PATCH/PUT /association_details/1.json
  def update
    respond_to do |format|
      if @association_detail.update(association_detail_params)
        format.html { redirect_to @association_detail, notice: 'Association detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @association_detail }
      else
        format.html { render :edit }
        format.json { render json: @association_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /association_details/1
  # DELETE /association_details/1.json
  def destroy
    @association_detail.destroy
    respond_to do |format|
      format.html { redirect_to association_details_url, notice: 'Association detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_association_detail
      @association_detail = AssociationDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def association_detail_params
      params.require(:association_detail).permit(:name, :short_name, :contact_phone, :contact_email, :address, :logo, :about_association)
    end
end
