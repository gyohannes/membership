class ReportsController < ApplicationController
  respond_to :js
  def trainings
    @trainings = []
    if request.post?
      if params[:training_type] or params[:program_area] or params[:training_title]
        @trainings = Training.search_by_tpt(params[:training_type],params[:program_area],params[:training_title])
        respond_to do |format|
          format.js
        end
      end
    end
  end

  def health_workers
    @health_workers = []
  end

  def trainees
    @trainees = []
    if request.post?
      @trainees = Trainee.search(params[:search][:organization_unit], params[:search][:program_area], params[:search][:training_title],
                                 params[:search][:category], params[:search][:training_type], params[:search][:trainee_status])
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

end
