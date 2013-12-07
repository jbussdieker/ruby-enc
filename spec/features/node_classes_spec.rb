require 'spec_helper'

describe 'Node Classes' do
  describe 'Manage Node Classes' do
    it 'Adds a new node class and displays the results', :js => true do
      visit node_classes_path
      name = Faker::Lorem.word

      expect {
        click_link 'Add Class'
        fill_in 'Name', :with => name
        click_button 'Create Node class'
      }.to change(NodeClass, :count).by(1)

      expect(page).to have_content "Class: #{name}"
    end

    it 'Edits a node class', :js => true do
      node_class = FactoryGirl.create(:node_class)
      name = Faker::Lorem.word

      visit node_class_path(node_class)
      click_link 'Edit'
      fill_in 'Name', :with => name
      click_button 'Update Node class'

      expect(page).to have_content "Class: #{name}"
    end

    it 'Deletes a node class', :js => true do
      node_class = FactoryGirl.create(:node_class)
      visit node_classes_path

      within('#node_classes') do
        click_link node_class.name
      end

      expect(page).to have_content "Class: #{node_class.name}"

      expect {
        click_link 'Delete'
        alert = page.driver.browser.switch_to.alert
        alert.accept
        expect(page).to_not have_content node_class.name
      }.to change(NodeClass, :count).by(-1)
    end
  end
end
