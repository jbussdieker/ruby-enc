class NodeClassesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @node_classes = NodeClass.order(sort_column + " " + sort_direction)
  end

  def show
    @node_class = NodeClass.find(params[:id])
  end

  def new
    @node_class = NodeClass.new
  end

  def create
    @node_class = NodeClass.new(params[:node_class])
    if @node_class.save
      redirect_to node_classes_path
    else
      render 'new'
    end
  end

  def edit
    @node_class = NodeClass.find(params[:id])
  end

  def update
    @node_class = NodeClass.find(params[:id])
    if @node_class.update_attributes(params[:node_class])
      redirect_to node_classes_path
    else
      render 'edit'
    end
  end

  def destroy
    @node_class = NodeClass.find(params[:id])
    @node_class.destroy
    redirect_to node_classes_path
  end

  private

  def sort_column
    NodeClass.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
