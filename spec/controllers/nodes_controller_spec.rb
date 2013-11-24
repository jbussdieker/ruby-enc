require 'spec_helper'

describe NodesController do
  describe "GET #index" do
    it "populates an array of nodes" do
      node = FactoryGirl.create(:node)
      get :index
      assigns(:nodes).should eq([node])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested node to @node" do
      node = FactoryGirl.create(:node)
      get :show, id: node
      assigns(:node).should eq(node)
    end

    it "renders the #show view" do
      node = FactoryGirl.create(:node)
      get :show, id: node
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new node to @node" do
      get :new
      assigns(:node).should be_kind_of Node
    end

    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested node to @node" do
      node = FactoryGirl.create(:node)
      get :edit, id: node
      assigns(:node).should eq(node)
    end

    it "renders the #edit view" do
      node = FactoryGirl.create(:node)
      get :edit, id: node
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it "creates a new node" do
      expect {
        post :create, node: FactoryGirl.attributes_for(:node)
      }.to change(Node, :count).by(1)
    end

    it "renders the #edit view" do
      post :create, node: FactoryGirl.attributes_for(:node)
      response.should redirect_to Node.last
    end
  end
end
