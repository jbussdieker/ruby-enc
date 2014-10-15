class ParametersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @parameters = Parameter.where(parameterable_id: nil).order(sort_column + " " + sort_direction)
    render_collection(@parameters)
  end

  def new
    @parameter = Parameter.new
  end

  def create
    @parameter = Parameter.create(params[:parameter])
    render_create(@parameter, parameters_path)
  end

  private

  def sort_column
    params[:sort] || "'key'"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
