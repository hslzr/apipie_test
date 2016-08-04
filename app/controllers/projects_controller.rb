class ProjectsController < ApplicationController
  layout false

  def index
    render json: Project.all, status: 200
  end

  def show
    project = Project.find(params[:id])
    render json: project, status: 200 if project
    render json: { message: "Not found" }, status: 404
  end

  def create
    project = Project.create(project_params)
    render json: project, status: 201 if project
    render json: { project: { errors: project.errors } }, status: 422
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      render json: project, status: 201
    end
    render json: { project: { errors: project.errors } }, status: 422
  end

  def delete
    Project.find(params[:id]).destroy
    head 204
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end
end
