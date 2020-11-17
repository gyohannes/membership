class CpdCoursesController < ApplicationController
  before_action :set_cpd_course, only: [:show, :edit, :update, :destroy, :accept_or_reject]

  # GET /cpd_courses
  # GET /cpd_courses.json
  def index
    @cpd_courses = CpdCourse.all
  end

  def accept_or_reject
    @cpd_course.update_attribute('status', params[:status])
    flash[:notice] = "CPD course successfully #{params[:status]}"
    render 'show'
  end

  # GET /cpd_courses/1
  # GET /cpd_courses/1.json
  def show
  end

  # GET /cpd_courses/new
  def new
    @cpd_course = CpdCourse.new
    @cpd_course.cpd_provider = current_user.cpd_provider
  end

  # GET /cpd_courses/1/edit
  def edit
  end

  # POST /cpd_courses
  # POST /cpd_courses.json
  def create
    @cpd_course = CpdCourse.new(cpd_course_params)

    respond_to do |format|
      if @cpd_course.save
        format.html { redirect_to @cpd_course, notice: 'Cpd course was successfully created.' }
        format.json { render :show, status: :created, location: @cpd_course }
      else
        format.html { render :new }
        format.json { render json: @cpd_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpd_courses/1
  # PATCH/PUT /cpd_courses/1.json
  def update
    respond_to do |format|
      if @cpd_course.update(cpd_course_params)
        format.html { redirect_to @cpd_course, notice: 'Cpd course was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpd_course }
      else
        format.html { render :edit }
        format.json { render json: @cpd_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpd_courses/1
  # DELETE /cpd_courses/1.json
  def destroy
    @cpd_course.destroy
    respond_to do |format|
      format.html { redirect_to cpd_courses_url, notice: 'Cpd course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpd_course
      @cpd_course = CpdCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpd_course_params
      params.require(:cpd_course).permit(:cpd_provider_id, :activity_title, :method_of_delivery, :date_of_activity,
                                         :target_audience, :venue_of_activity, :registration_fee_involved_for_participants,
                                         :duration_of_the_learning_activity, :suggested_ceu, :ethics, :mechanism_for_monitoring,
                                         :mechanism_for_monitoring_attendance, :attendance_certificate)
    end
end
