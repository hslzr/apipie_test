class ProjectsController < ApplicationController
  layout false

  api! 'Get all projects'
  def index
    render json: Project.all, status: 200
  end

  api! 'Project show'
  error code: 404, desc: 'Project not found'
  formats ['json', 'jsonp']
  meta message: 'Something meta?'
  example "
  project: {
    'id': 1,
    'title': 'Le chateau du le chat noir',
    'created_at': #{Time.now - 1.day},
    'updated_at': #{Time.now - 1.day}
  }
  "
  param :id, String, required: true
  def show
    project = Project.find(params[:id])
    if project
      render json: project, status: 200
    else
      render json: { message: "Not found" }, status: 404
    end
  end

  api! 'Create a project'
  error code: 404, desc: 'How did you even...?'
  error code: 422, desc: 'Unprocessable entity'
  header 'ClientId', 'Headers can\'t be validated by apipie :c', required: true
  meta  :author => { name: 'Salazar', username: 'hslzr', created_at: '04-Ago-16' }
  param :project, Hash, desc: 'Project info', required: true do
    param :title, String, required: true, desc: 'Project\'s title'
  end
  document 'projects/create.md'
  def create
    project = Project.create(project_params)
    if project
      render json: project, status: 201 if project
    else
      render json: { project: { errors: project.errors } }, status: 422
    end
  end

  api :PUT, 'projects/:id', 'Update a project'
  param :id, String, desc: 'ID of the project to update'
  param :project, Hash, required: true, desc: 'Project\'s info' do
    param :title, String, required: true, desc: 'Project\'s title'
  end
  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      render json: project, status: 201
    else
      render json: { project: { errors: project.errors } }, status: 422
    end
  end

  def delete
    Project.find(params[:id]).destroy
    head 204
  end

  api! 'Unfinished projects'
  error code: 422
  def unfinished
    # TODO
    render json: Project.all, status: 200
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end
end
