class NodeClassesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :set_node_class, only: [:show, :edit, :update, :destroy]

  def index
    @node_classes = NodeClass.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_classes }
    end
  end

  def show
    @nodes = @node_class.nodes.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node_class }
    end
  end

  def new
    @node_class = NodeClass.new
  end

  def edit
  end

  def create
    @node_class = NodeClass.new(params[:node_class])

    render_create(@node_class)
  end

  def update
    render_update(@node_class, params[:node_class])
  end

  def destroy
    render_destroy(@node_class)
  end

  private

  def set_node_class
    @node_class = NodeClass.find_by_name(params[:id])
  end

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
