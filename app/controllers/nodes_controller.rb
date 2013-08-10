class NodesController < ApplicationController
  def index
    @nodes = Node.all
  end

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to nodes_path
    else
      render 'new'
    end
  end

  def show
    @node = Node.find_by_name(params[:id])
  end

  def edit
    @node = Node.find_by_name(params[:id])
  end

  def destroy
    @node = Node.find_by_name(params[:id])
    @node.delete
    redirect_to nodes_path
  end

  def update
    @node = Node.find_by_name(params[:id])
    if @node.update_attributes(params[:node])
      redirect_to nodes_path
    else
      render 'edit'
    end
  end
end
