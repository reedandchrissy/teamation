class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if params[:teams].nil?
      @teams = {}
    else
      @teams = params[:teams]
    end
    @students = @course.students
    @student_string = ""
    @students.each do |student|
      @student_string += student.firstname + " " + student.lastname + ", "
    end
    @groups = @course.groups
    @group_hash = {}
    @groups.each do |group|
      group_string = ""
      group.students.each do |student|
        group_string += student.firstname + " " + student.lastname + ", "
      end
      @group_hash[group.project_name] = group_string
    end
  end

  #GET /courses/1/create_groups
  def create_groups
    #session[:teams] = {"a" => [1,2,3], "b" => [3,4,5]}
    #@teams = session[:teams]
    puts params.inspect
    @course = Course.find(params[:id])
    redirect_to :controller => 'courses', :action => 'show', :id => params[:id], :teams => {"a" => [1,2,3], "b" => [3,4,5]}
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :pin, :professor_id)
    end
end
