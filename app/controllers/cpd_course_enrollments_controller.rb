class CpdCourseEnrollmentsController < ApplicationController
  before_action :set_cpd_course_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /cpd_course_enrollments
  # GET /cpd_course_enrollments.json
  def index
    @cpd_course_enrollments = CpdCourseEnrollment.all
  end

  # GET /cpd_course_enrollments/1
  # GET /cpd_course_enrollments/1.json
  def show
  end

  # GET /cpd_course_enrollments/new
  def new
    @cpd_course_enrollment = CpdCourseEnrollment.new
  end

  # GET /cpd_course_enrollments/1/edit
  def edit
  end

  # POST /cpd_course_enrollments
  # POST /cpd_course_enrollments.json
  def create
    @cpd_course_enrollment = CpdCourseEnrollment.new(cpd_course_enrollment_params)

    respond_to do |format|
      if @cpd_course_enrollment.save
        format.html { redirect_to @cpd_course_enrollment, notice: 'Cpd course enrollment was successfully created.' }
        format.json { render :show, status: :created, location: @cpd_course_enrollment }
      else
        format.html { render :new }
        format.json { render json: @cpd_course_enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpd_course_enrollments/1
  # PATCH/PUT /cpd_course_enrollments/1.json
  def update
    respond_to do |format|
      if @cpd_course_enrollment.update(cpd_course_enrollment_params)
        format.html { redirect_to @cpd_course_enrollment, notice: 'Cpd course enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpd_course_enrollment }
      else
        format.html { render :edit }
        format.json { render json: @cpd_course_enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpd_course_enrollments/1
  # DELETE /cpd_course_enrollments/1.json
  def destroy
    @cpd_course_enrollment.destroy
    respond_to do |format|
      format.html { redirect_to cpd_course_enrollments_url, notice: 'Cpd course enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpd_course_enrollment
      @cpd_course_enrollment = CpdCourseEnrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpd_course_enrollment_params
      params.require(:cpd_course_enrollment).permit(:cpd_course_id, :from, :to,
                                                    enrollment_credits_attributes: [:id, :cpd_course_enrollment_id, :person_id, :ceu, :_destroy ])
    end
end
