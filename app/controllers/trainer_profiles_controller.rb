class TrainerProfilesController < ApplicationController
  before_action :set_trainer_profile, only: [:show, :edit, :update, :destroy]

  # GET /trainer_profiles
  # GET /trainer_profiles.json
  def index
    @trainer_profiles = TrainerProfile.all
  end

  # GET /trainer_profiles/1
  # GET /trainer_profiles/1.json
  def show
  end

  # GET /trainer_profiles/new
  def new
    @person = Person.find(params[:person])
    @trainer_profile = TrainerProfile.new
    @trainer_profile.person = @person
  end

  # GET /trainer_profiles/1/edit
  def edit
  end

  # POST /trainer_profiles
  # POST /trainer_profiles.json
  def create
    @trainer_profile = TrainerProfile.new(trainer_profile_params)
    respond_to do |format|
      if @trainer_profile.save
        format.html { redirect_to person_path(@trainer_profile.person), notice: 'Trainer profile was successfully created.' }
        format.json { render :show, status: :created, location: @trainer_profile }
      else
        format.html { render :new }
        format.json { render json: @trainer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainer_profiles/1
  # PATCH/PUT /trainer_profiles/1.json
  def update
    respond_to do |format|
      if @trainer_profile.update(trainer_profile_params)
        format.html { redirect_to @trainer_profile, notice: 'Trainer profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @trainer_profile }
      else
        format.html { render :edit }
        format.json { render json: @trainer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainer_profiles/1
  # DELETE /trainer_profiles/1.json
  def destroy
    @trainer_profile.destroy
    respond_to do |format|
      format.html { redirect_to trainer_profiles_url, notice: 'Trainer profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trainer_profile
      @trainer_profile = TrainerProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trainer_profile_params
      params.require(:trainer_profile).permit(:person_id, :trainer_type, :primary_job, :secondary_job,
                                              trainer_training_titles_attributes: [:id, :trainer_profile_id,:training_title_id, :training_type, :_destroy],
                                              trainer_languages_attributes: [:id, :trainer_profile_id,:language_id, :_destroy])
    end
end
