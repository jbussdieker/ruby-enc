require 'spec_helper'

describe NodeGroupsController do
  describe "GET #index" do
    it "populates an array of node_groups" do
      node_group = FactoryGirl.create(:node_group)
      get :index
      assigns(:node_groups).should eq([node_group])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end

    it "renders json" do
      node_group = FactoryGirl.create(:node_group)
      get :index, format: :json
    end
  end

  describe "GET #show" do
    it "assigns the requested node_group to @node_group" do
      node_group = FactoryGirl.create(:node_group)
      get :show, id: node_group
      assigns(:node_group).should eq(node_group)
    end

    it "renders the #show view" do
      node_group = FactoryGirl.create(:node_group)
      get :show, id: node_group
      response.should render_template :show
    end

    it "renders json" do
      node_group = FactoryGirl.create(:node_group)
      get :show, id: node_group, format: :json
    end
  end

  describe "GET #new" do
    it "assigns a new node_group to @node_group" do
      get :new
      assigns(:node_group).should be_kind_of NodeGroup
    end

    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested node_group to @node_group" do
      node_group = FactoryGirl.create(:node_group)
      get :edit, id: node_group
      assigns(:node_group).should eq(node_group)
    end

    it "renders the #edit view" do
      node_group = FactoryGirl.create(:node_group)
      get :edit, id: node_group
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:attributes) { FactoryGirl.attributes_for(:node_group) }

      it "creates a new node_group" do
        expect {
          post :create, node_group: attributes
        }.to change(NodeGroup, :count).by(1)
      end

      it "renders the #edit view" do
        post :create, node_group: attributes
        response.should redirect_to NodeGroup.last
      end
    end

    context "with invalid attributes" do
      let(:attributes) { FactoryGirl.attributes_for(:invalid_node_group) }

      it "does not create a new node_group" do
        expect {
          post :create, node_group: attributes
        }.to_not change(NodeGroup, :count)
      end

      it "renders the #new view" do
        post :create, node_group: attributes
        response.should render_template :new
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @node_group = FactoryGirl.create(:node_group, name: 'foo')
    end

    context "with valid attributes" do
      let(:attributes) { FactoryGirl.attributes_for(:node_group, name: 'bar') }

      it "located the requested @node_group" do
        put :update, id: @node_group, node_group: attributes
        assigns(:node_group).should eq(@node_group)
      end

      it "changes @node_group's attributes" do
        put :update, id: @node_group, node_group: attributes
        @node_group.reload
        @node_group.name.should eq('bar')
      end

      it "redirects to show updated node group" do
        put :update, id: @node_group, node_group: attributes
        response.should redirect_to NodeGroup.last
      end
    end

    context "with invalid attributes" do
      let(:attributes) { FactoryGirl.attributes_for(:invalid_node_group) }

      it "does not change @node_group's attributes" do
        put :update, id: @node_group, node_group: attributes
        @node_group.reload
        @node_group.name.should eq('foo')
      end

      it "renders the #edit view" do
        put :update, id: @node_group, node_group: attributes
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the node group" do
      node_group = FactoryGirl.create(:node_group)
      expect {
        delete :destroy, id: node_group
      }.to change(NodeGroup, :count).by(-1)
    end

    it "redirects back to #index" do
      node_group = FactoryGirl.create(:node_group)
      delete :destroy, id: node_group
      response.should redirect_to node_groups_path
    end
  end
end
