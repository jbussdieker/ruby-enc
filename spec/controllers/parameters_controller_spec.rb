require 'spec_helper'

describe ParametersController do
  describe "GET #index" do
    it "populates an array of parameters" do
      parameter = FactoryGirl.create(:parameter)
      get :index
      assigns(:parameters).should eq([parameter])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #new" do
    it "assigns a new parameter to @parameter" do
      get :new
      assigns(:parameter).should be_kind_of Parameter
    end

    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new node_class" do
        expect {
          post :create, parameter: FactoryGirl.attributes_for(:parameter)
        }.to change(Parameter, :count).by(1)
      end

      it "redirects to the new parameter" do
        post :create, parameter: FactoryGirl.attributes_for(:parameter)
        response.should redirect_to parameters_path
      end
    end

    context "with invalid attributes" do
      it "does not create a new parameter" do
        expect {
          post :create, parameter: FactoryGirl.attributes_for(:invalid_parameter)
        }.to_not change(Parameter, :count)
      end

      it "renders the #new view" do
        post :create, parameter: FactoryGirl.attributes_for(:invalid_parameter)
        response.should render_template :new
      end
    end
  end
end
