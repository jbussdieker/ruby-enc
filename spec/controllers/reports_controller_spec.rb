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

  if ENV["DB"] != "sqlite3"
    describe "GET #report_history" do
      let(:time) { Time.parse("2014-01-01 23:59:00 +0000") }
      let(:result) { { time.to_date => 1 } }

      before :each do
        @report = FactoryGirl.create(:report, time: time)
      end

      it "assigns the requested report to @report" do
        get :report_history
        assigns(:history).should eq(result)
      end

      it "renders the #show view" do
        get :report_history
        response.body.should == result.to_json
      end
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
    let(:report_data) { File.read("spec/fixtures/reports/puppet-3.3.2/changed.yaml") }

    before do
      @request.env['RAW_POST_DATA'] = report_data
    end

    it "creates a report" do
      expect {
        post :upload
      }.to change(Report, :count).by(1)
    end

    it "creates report logs" do
      expect {
        post :upload
      }.to change(ReportLog, :count).by(5)
    end

    it "creates resource statuses" do
      expect {
        post :upload
      }.to change(ResourceStatus, :count).by(1)
    end

    it "creates metrics" do
      expect {
        post :upload
      }.to change(Metric, :count).by(16)
    end

    it "returns OK" do
      post :upload
      response.body.should == "OK"
    end
  end
end
