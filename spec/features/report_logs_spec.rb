require 'spec_helper'

describe 'Report Logs' do
  describe 'List Report Logs' do
    it 'Shows Reports', :js => true do
      report = FactoryGirl.create(:report_with_dependents)
      visit report_logs_path
      expect(page).to have_content "Report Logs"
    end
  end
end
