class TrainingTitlesController < ApplicationController
  before_action :set_training_title, only: [:show, :edit, :update, :destroy]

  def training_titles_by_area
    render json: TrainingTitle.joins(:program_area).group('name').count
  end

  def load_training_titles
    @filtered_training_titles = TrainingTitle.search(params[:program_area],params[:training_title])
    render partial: 'training_titles'
  end

  # GET /training_titles
  # GET /training_titles.json
  def index
    @training_titles = TrainingTitle.all
    @filtered_training_titles = TrainingTitle.all
  end

  # GET /training_titles/1
  # GET /training_titles/1.json
  def show
  end

  # GET /training_titles/new
  def new
    @training_title = TrainingTitle.new
  end

  # GET /training_titles/1/edit
  def edit
  end

  # POST /training_titles
  # POST /training_titles.json
  def create
    @training_title = TrainingTitle.new(training_title_params)

    respond_to do |format|
      if @training_title.save
        format.html { redirect_to training_titles_path, notice: 'Training title was successfully created.' }
        format.json { render :show, status: :created, location: @training_title }
      else
        format.html { render :new }
        format.json { render json: @training_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_titles/1
  # PATCH/PUT /training_titles/1.json
  def update
    respond_to do |format|
      if @training_title.update(training_title_params)
        format.html { redirect_to training_titles_path, notice: 'Training title was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_title }
      else
        format.html { render :edit }
        format.json { render json: @training_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_titles/1
  # DELETE /training_titles/1.json
  def destroy
    @training_title.destroy
    respond_to do |format|
      format.html { redirect_to training_titles_url, notice: 'Training title was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_title
      @training_title = TrainingTitle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_title_params
      params.require(:training_title).permit(:title, :program_area_id, :duration, :duration_in,
                                             :maximum_number_of_participants, :training_method_id, :description, :topic_image)
    end
end
