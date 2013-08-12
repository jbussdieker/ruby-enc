class NodesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @nodes = Node.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  def show
    @node = Node.find_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node }
    end
  end

  def new
    @node = Node.new
    @node.parameters.build
  end

  def edit
    @node = Node.find_by_name(params[:id])
    @node.parameters.new
  end

  def create
    @node = Node.new(params[:node])
 
    respond_to do |format|
      if @node.save
        format.html { redirect_to nodes_path, notice: 'Node was successfully created.' }
        format.json { render json: @node, status: :created, location: nodes_path }
      else
        format.html { render action: "new" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
 end

  def update
    @node = Node.find_by_name(params[:id])
 
    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node = Node.find_by_name(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_path }
      format.json { head :no_content }
    end
  end

  def unresponsive
    @nodes = Node.unresponsive.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def failed
    @nodes = Node.failed.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def pending
    @nodes = Node.pending.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def changed
    @nodes = Node.changed.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def unchanged
    @nodes = Node.unchanged.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def unreported
    @nodes = Node.unreported.order(sort_column + " " + sort_direction)
    render 'index'
  end

  private

  def sort_column
    Node.column_names.include?(params[:sort]) ? params[:sort] : "reported_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
