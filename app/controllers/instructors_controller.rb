class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    instructors = Instructor.all
    render json: intructors, status: :ok
  end

  def show
    instructor = find_instructor
    render json: instructor, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def update
    instructor = Instructor.update!(instructor_params)
    render json: instructor, status: :created
  end

  def destroy
    instructor = Instructor.find_by(id: params[:id])
    if instructor
      instructor.destroy
      head :no_content
    else
      render json: { error: "Instructor not found" }, status: :not_found
    end
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    instructor = Instructor.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end


end
