class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:landing_page]

  def landing_page

  end

  def index
    @organization_unit = OrganizationUnit.all
    @upcoming_events = Event.where('start_date > ?', Date.today)
    @people = current_user.organization_unit.try(:sub_people) || []
    @members_paid = current_user.organization_unit.try(:sub_people).joins(:payments).where('budget_year_id = ?', BudgetYear.active.try(:id)) rescue nil
    @members_not_paid = @people - @members_paid rescue nil
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

    #Trainees funded by institution
    if @institution
      @institution_trainees = @institution.trainees
      @institution_trainings = @institution.all_trainings
    end
  end

  def member_dashboard
    @upcoming_events = Event.where('start_date > ?', Date.today)
  end

  def payment_dashboard
    @people = current_user.organization_unit.try(:sub_people) || []
    @members_paid = current_user.organization_unit.try(:sub_people).joins(:payments).where('budget_year_id = ?', BudgetYear.active.try(:id))
    @members_not_paid = current_user.organization_unit.try(:sub_people) - @members_paid
  end

  def training_dashboard
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

  end

end
