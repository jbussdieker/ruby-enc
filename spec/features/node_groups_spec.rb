require 'spec_helper'

describe 'Node Groups' do
  describe 'Manage Node Groups' do
    it 'Adds a new node group and displays the results', :js => true do
      visit node_groups_path
      name = Faker::Lorem.word

      expect {
        click_link 'Add Group'
        fill_in 'Name', :with => name
        click_button 'Create Node group'
      }.to change(NodeGroup, :count).by(1)

      expect(page).to have_content "Group: #{name}"
    end

    it 'Edits a node group', :js => true do
      node_group = FactoryGirl.create(:node_group)
      name = Faker::Lorem.word

      visit node_group_path(node_group)
      click_link 'Edit'
      fill_in 'Name', :with => name
      click_button 'Update Node group'

      expect(page).to have_content "Group: #{name}"
    end

    it 'Deletes a node group', :js => true do
      node_group = FactoryGirl.create(:node_group)
      visit node_groups_path

      within('#node_groups') do
        click_link node_group.name
      end

      expect(page).to have_content "Group: #{node_group.name}"

      expect {
        click_link 'Delete'
        alert = page.driver.browser.switch_to.alert
        alert.accept
        expect(page).to_not have_content node_group.name
      }.to change(NodeGroup, :count).by(-1)
    end
  end
end
