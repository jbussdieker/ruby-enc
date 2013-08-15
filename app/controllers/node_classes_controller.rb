class NodeClassesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @node_classes = NodeClass.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_classes }
    end
  end

  def show
    @node_class = NodeClass.find_by_name(params[:id])
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
    @node_class = NodeClass.find_by_name(params[:id])
  end

  def create
    @node_class = NodeClass.new(params[:node_class])

    respond_to do |format|
      if @node_class.save
        format.html { redirect_to @node_class, notice: 'Node class was successfully created.' }
        format.json { render json: @node_class, status: :created, location: @node_class }
      else
        format.html { render action: "new" }
        format.json { render json: @node_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @node_class = NodeClass.find_by_name(params[:id])

    respond_to do |format|
      if @node_class.update_attributes(params[:node_class])
        format.html { redirect_to @node_class, notice: 'Node class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node_class = NodeClass.find_by_name(params[:id])
    @node_class.destroy

    respond_to do |format|
      format.html { redirect_to node_classes_path }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
