class HomeController < ApplicationController
  before_action :authenticate_user!

  def index

    #All Trainees
    @trainees = current_user.organization_unit.try(:trainees)
    #upcoming trainings
    type_upcoming = 'upcoming'
    @upcoming_trainings = Training.load_trainings(current_user,type_upcoming)

    #Pre-Service trainings
    type_pre = 'Pre-Service'
    @pre_trainings = Training.load_trainings(current_user,type_pre)

    #In-Service trainings
    type_in = 'In-Service'
    @in_trainings = Training.load_trainings(current_user,type_in)

    #trainings in progress
    type_progressing = 'progress'
    @progressing_trainings = Training.load_trainings(current_user,type_progressing)

    #load health workers
    @people = current_user.organization_unit.try(:sub_people) || []

    #Trainees funded by institution
    if @institution
      @institution_trainees = @institution.trainees
      @institution_trainings = @institution.all_trainings
    end
  end

end
