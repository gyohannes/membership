class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :confirm]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  def confirm
    @member.update(status: true)
    flash[:notice] = 'Member Successfully Confirmed'
    render action: 'show'
  end

  def load_members
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members = @organization_unit.sub_members
    render partial: 'members'
  end

  def members_paid
    @members_paid = current_user.organization_unit.paid_members
  end

  def load_members_paid
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members_paid = @organization_unit.paid_members
    render partial: 'members_paid'
  end

  def members_not_paid
    @members_not_paid = current_user.organization_unit.try(:sub_members) - current_user.organization_unit.paid_members
  end

  def load_members_not_paid
    @organization_unit  = OrganizationUnit.find(params[:node])
    @members_not_paid = @organization_unit.sub_members - @organization_unit.paid_members
    render partial: 'members_not_paid'
  end

  def members_by_type
    members = current_user.organization_unit.sub_members.joins(:membership_type).group('membership_types.name').count
    render json: members
  end

  def members_by_membership_type_and_payment_status
    members = []
    ['Paid', 'Not Paid'].each do |c|
      members << {name: c, data: MembershipType.all.map{|mt| [mt.to_s, mt.members_by_status(current_user,c).count]} }
    end
    render json: members
  end

  def id_cards
    @members = []
    member_ids = params[:members].delete_if{|e| e=='0'} rescue nil
    @members = member_ids.blank? ? [] : Member.find(member_ids)
    @members.each do |member|
      barcode = Barby::Code128.new(member.id_number)
      File.open("#{Rails.root}/public/barcodes/#{member.id_number}.png", 'wb'){|f|
        f.write barcode.to_png(:height => 20, :margin => 5)
      }
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "id_cards",
               disable_smart_shrinking: false,
               disposition: 'attachment',
               encoding: 'utf8'
      end
    end
  end

  def load_paid_members
    budget_year = BudgetYear.active
    organization_unit  = OrganizationUnit.find(params[:node])
    @members = budget_year.blank? ? [] : organization_unit.paid_members
    render partial: 'id_cards'
  end

  def membership_idcard
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Membership ID Card",
               disposition: 'attachment',
               encoding: 'utf8'
      end
    end
  end

  def confirm
    @member.update(status: true)
    flash[:notice] = 'Member Successfully Confirmed'
    render action: 'show'
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
    @member.user_id = current_user.id
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    category = @member.category
    respond_to do |format|
      if @member.save
        if category == Constants::INDIVIDUAL
          redirect_to new_individual_path(member: @member.id)
        elsif category == Constants::STUDENT
          redirect_to new_student_path(member: @member.id)
        elsif category == Constants::INSTITUTION
          redirect_to new_institution_path(member: @member.id)
        end
        format.html
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        category = @member.category
        if category == Constants::INDIVIDUAL
          unless @member.individual.blank?
            redirect_to edit_individual_path(@member.individual)
          else
            redirect_to new_individual_path(member: @member.id)
          end
        elsif category == Constants::STUDENT
          unless @member.student.blank?
            redirect_to edit_student_path(@member.student)
          else
            redirect_to new_student_path(member: @member.id)
          end
        elsif category == Constants::INSTITUTION
          unless @member.institution.blank?
            redirect_to edit_institution_path(@member.institution)
          else
            redirect_to new_institution_path(member: @member.id)
          end
        end
        format.html
        format.json
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:user_id, :category, :membership_type_id, :id_number)
    end
end
