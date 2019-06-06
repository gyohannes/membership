class UsersController < ApplicationController
  layout 'application'
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @type = params[:type]
    @users = User.load_users(current_user, @type)
  end

  def load_users
    @organization_unit  = OrganizationUnit.find(params[:node])
    @users = @organization_unit.sub_users
    render partial: 'users'
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @institutions = @institution ? [@institution] : Institution.all
    @organization_unit = OrganizationUnit.find_by_id(params[:organization_unit])
    @user = User.new
    @user.user_type = params[:type]
    @user.organization_unit = @organization_unit unless @organization_unit.blank?
    @organization_units = [@organization_unit]
  end

  # GET /users/1/edit
  def edit
    @organization_units = current_user.parent_org_unit.try(:sub_units)
    @institutions = @institution ? [@institution] : Institution.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @institutions = @institution ? [@institution] : Institution.all
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path(type: @user.user_type), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path(type: @user.user_type), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    type = @user.user_type
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url(type: type), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_type, :email, :organization_unit_id, :facility_id, :institution_id, :role_id, :password, :password_confirmation)
    end
end
