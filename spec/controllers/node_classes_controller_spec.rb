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
    context "with valid attributes" do
      it "creates a new node_class" do
        expect {
          post :create, node_class: FactoryGirl.attributes_for(:node_class)
        }.to change(NodeClass, :count).by(1)
      end

      it "redirects to the new node class" do
        post :create, node_class: FactoryGirl.attributes_for(:node_class)
        response.should redirect_to NodeClass.last
      end
    end

    context "with invalid attributes" do
      it "does not create a new node_class" do
        expect {
          post :create, node_class: FactoryGirl.attributes_for(:invalid_node_class)
        }.to_not change(NodeClass, :count)
      end

      it "renders the #new view" do
        post :create, node_class: FactoryGirl.attributes_for(:invalid_node_class)
        response.should render_template :new
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @node_class = FactoryGirl.create(:node_class, name: 'foo')
    end

    context "with valid attributes" do
      it "located the requested @node_class" do
        put :update, id: @node_class, node: FactoryGirl.attributes_for(:node_class)
        assigns(:node_class).should eq(@node_class)
      end

      it "changes @node_class's attributes" do
        put :update, id: @node_class, 
          node_class: FactoryGirl.attributes_for(:node_class, name: 'bar')
        @node_class.reload
        @node_class.name.should eq('bar')
      end

      it "redirects to show updated node class" do
        put :update, id: @node_class, node_class: FactoryGirl.attributes_for(:node_class)
        response.should redirect_to NodeClass.last
      end
    end

    context "with invalid attributes" do
      it "does not update the node_class" do
        put :update, id: @node_class, node_class: FactoryGirl.attributes_for(:invalid_node_class)
        @node_class.reload
        @node_class.name.should eq('foo')
      end

      it "renders the #edit view" do
        put :update, id: @node_class, node_class: FactoryGirl.attributes_for(:invalid_node_class)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the node class" do
      node_class = FactoryGirl.create(:node_class)
      expect {
        delete :destroy, id: node_class
      }.to change(NodeClass, :count).by(-1)
    end

    it "redirects back to #index" do
      node_class = FactoryGirl.create(:node_class)
      delete :destroy, id: node_class
      response.should redirect_to node_classes_path
    end
  end
end
