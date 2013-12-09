require 'spec_helper'

describe 'Reports' do
  describe 'Manage Reports' do
    it 'Deletes a report', :js => true do
      report = FactoryGirl.create(:report_with_dependents)
      visit reports_path

      first("#report-#{report.id} a").click

      expect(page).to have_content "Report: "

      expect {
        click_link 'Delete'
        alert = page.driver.browser.switch_to.alert
        alert.accept
        expect(page).to_not have_selector("#report-#{report.id}")
      }.to change(Report, :count).by(-1)
    end
  end
end
