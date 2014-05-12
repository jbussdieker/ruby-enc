require 'spec_helper'

describe ReportsController do
  describe "GET #index" do
    it "populates an array of reports" do
      report = FactoryGirl.create(:report)
      get :index
      assigns(:reports).should eq([report])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    before :each do
      @report = FactoryGirl.create(:report)
    end

    it "assigns the requested report to @report" do
      get :show, id: @report
      assigns(:report).should eq(@report)
    end

    it "renders the #show view" do
      get :show, id: @report
      response.should render_template :show
    end
  end

  describe "GET #parse" do
    before :each do
      @report = FactoryGirl.create(:report)
      Report.any_instance.stub(:parse)
    end

    it "assigns the requested report to @report" do
      get :parse, id: @report
      assigns(:report).should eq(@report)
    end

    it "parses the report" do
      Report.any_instance.should_receive(:parse)
      get :parse, id: @report
    end

    it "redirects back to #index" do
      get :parse, id: @report
      response.should redirect_to reports_path
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @report = FactoryGirl.create(:report)
    end

    it "deletes the report" do
      expect {
        delete :destroy, id: @report
      }.to change(Report, :count).by(-1)
    end

    it "redirects back to #index" do
      delete :destroy, id: @report
      response.should redirect_to reports_path
    end
  end

  describe "POST #upload" do
    before :each do
      Report.any_instance.stub(:write)
      Report.any_instance.stub(:parse)
    end

    it "creates a report" do
      expect {
        post :upload
      }.to change(Report, :count).by(1)
    end

    it "writes the report" do
      Report.any_instance.should_receive(:write)
      post :upload
    end

    it "parses the report" do
      Report.any_instance.should_receive(:parse)
      post :upload
    end

    it "returns OK" do
      post :upload
      response.body.should == "OK"
    end
  end
end
