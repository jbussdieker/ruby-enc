require 'spec_helper'

describe 'Reports' do
  describe 'Manage Reports' do
    it 'Deletes a report', :js => true do
      report = FactoryGirl.create(:report_with_dependents)
      visit reports_path

      within('#reports') do
        click_link report.id
      end

      expect(page).to have_content "Report: #{report.name}"

      expect {
        click_link 'Delete'
        alert = page.driver.browser.switch_to.alert
        alert.accept
        expect(page).to_not have_content report.id
      }.to change(Report, :count).by(-1)
    end
  end
end
