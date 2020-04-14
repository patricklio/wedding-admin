class Admin::CoursesController < ApplicationController
    before_action :set_course, only: [:show, :edit, :update, :destroy]

    # GET /admin/courses
    def index
      @courses = Course.all
    end
  
    # GET /admin/courses/1
    def show
    end
  
    # GET /admin/courses/new
    def new
        @course = Course.new
    end
  
    # GET /admin/courses/1/edit
    def edit
    end
  
    # POST /admin/courses
    def create
      @course = Course.new(course_params)
  
      if @course.save
  
        if params[:commit] == "Enregistrer"
          redirect_to admin_courses_url, flash: { success: 'Les données ont bien été enregistrées.' }
        else
          redirect_to edit_admin_course_path(@course), flash: { success: "Les données ont bien été enregistrées." }
        end
  
      else
        render :new
      end
    end
  
    # PATCH/PUT /admin/courses/1
    def update
      if @course.update(course_params)
        if params[:commit] == "Enregistrer"
          redirect_to admin_courses_url, flash: { success: 'Les données ont bien été enregistrées.' }
        else
          redirect_to edit_admin_course_path(@course), flash: { success: "Les données ont bien été enregistrées." }
        end
      else
        render :edit
      end
    end
  
    # DELETE /admin/courses/1
    def destroy
      @course.destroy
  
      redirect_to admin_courses_url, flash: { success: 'Le cours a été supprimé avec succès' }
    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def course_params
      params
      .require(:course)
      .permit(:title,:author,:photo)
    end
  
end
