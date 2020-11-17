class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @regions = OrganizationUnit.regions
  end
  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    member = Member.find_by(id: params[:member])
    @student.member_id = params[:member]
    unless member.individual.blank?
      @student.person = member.individual.person
    else
      @student.build_person
    end
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    unless params[:student][:person_id].blank?
      student_params.delete(:person_attributes)
    end
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student.member, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student.member, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:member_id, :student_id_card, :person_id, person_attributes: [:id, :first_name, :father_name, :grand_father_name, :sex,
                                                                      :date_of_birth, :photo, :nationality, :country, :email,
                                                                      :mobile_phone, :organization_unit_id, :pobox])
    end
end
