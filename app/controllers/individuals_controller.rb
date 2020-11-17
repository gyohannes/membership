class IndividualsController < ApplicationController
  before_action :set_individual, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @membership_types = MembershipType.where(static: nil)
  end
  # GET /individuals
  # GET /individuals.json
  def index
    @individuals = Individual.all
  end

  # GET /individuals/1
  # GET /individuals/1.json
  def show
  end

  # GET /individuals/new
  def new
    @individual = Individual.new
    member = Member.find_by(id: params[:member])
    @individual.member_id = params[:member]
    unless member.student.blank?
      @individual.person = member.student.person
    else
      @individual.build_person
    end
  end

  # GET /individuals/1/edit
  def edit

  end

  # POST /individuals
  # POST /individuals.json
  def create
    unless params[:individual][:person_id].blank?
      individual_params.delete(:person_attributes)
    end
    @individual = Individual.new(individual_params)
    respond_to do |format|
      if @individual.save
        format.html { redirect_to @individual.member, notice: 'Member was successfully saved.' }
        format.json { render :show, status: :created, location: @individual }
      else
        format.html { render :new }
        format.json { render json: @individual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /individuals/1
  # PATCH/PUT /individuals/1.json
  def update
    respond_to do |format|
      if @individual.update(individual_params)
        format.html { redirect_to @individual.member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @individual }
      else
        format.html { render :edit }
        format.json { render json: @individual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /individuals/1
  # DELETE /individuals/1.json
  def destroy
    @individual.destroy
    respond_to do |format|
      format.html { redirect_to individuals_url, notice: 'Member was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual
      @individual = Individual.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_params
      params.require(:individual).permit(:member_id, :person_id, member_attributes: [:id, :membership_type_id],
                                         person_attributes: [:id, :first_name, :father_name, :grand_father_name, :sex,
                                                                         :date_of_birth, :photo, :nationality, :country, :email,
                                                                         :mobile_phone, :organization_unit_id, :pobox])
    end
end
