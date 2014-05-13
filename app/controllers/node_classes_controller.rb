class NodeClassesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :set_node_class, only: [:show, :edit, :update, :destroy]

  def index
    @node_classes = NodeClass.order(sort_column + " " + sort_direction)
    render_index(@node_classes)
  end

  def show
    @nodes = @node_class.nodes.order(sort_column + " " + sort_direction)
    render_show(@node_class)
  end

  def new
    @node_class = NodeClass.new
  end

  def create
    @node_class = NodeClass.new(node_class_params)
    render_create(@node_class)
  end

  def update
    render_update(@node_class, node_class_params)
  end

  def destroy
    render_destroy(@node_class)
  end

  private

  def set_node_class
    @node_class = NodeClass.find_by_name(params[:id])
  end

  def node_class_params
    params.require(:node_class).permit(:name)
  end

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
