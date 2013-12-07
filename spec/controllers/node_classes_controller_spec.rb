require 'spec_helper'

describe NodeClassesController do
  describe "GET #index" do
    it "populates an array of node_classes" do
      node_class = FactoryGirl.create(:node_class)
      get :index
      assigns(:node_classes).should eq([node_class])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested node_class to @node_class" do
      node_class = FactoryGirl.create(:node_class)
      get :show, id: node_class
      assigns(:node_class).should eq(node_class)
    end

    it "renders the #show view" do
      node_class = FactoryGirl.create(:node_class)
      get :show, id: node_class
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new node_class to @node_class" do
      get :new
      assigns(:node_class).should be_kind_of NodeClass
    end

    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested node_class to @node_class" do
      node_class = FactoryGirl.create(:node_class)
      get :edit, id: node_class
      assigns(:node_class).should eq(node_class)
    end

    it "renders the #edit view" do
      node_class = FactoryGirl.create(:node_class)
      get :edit, id: node_class
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    it "creates a new node_class" do
      expect {
        post :create, node_class: FactoryGirl.attributes_for(:node_class)
      }.to change(NodeClass, :count).by(1)
    end

    it "renders the #edit view" do
      post :create, node_class: FactoryGirl.attributes_for(:node_class)
      response.should redirect_to NodeClass.last
    end
  end
end
