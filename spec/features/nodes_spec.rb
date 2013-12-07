require 'spec_helper'

describe 'Nodes' do
  describe 'Manage Nodes' do
    it 'Adds a new node and displays the results', :js => true do
      visit nodes_path
      name = Faker::Lorem.word

      expect {
        click_link 'Add Node'
        fill_in 'Name', :with => name
        click_button 'Create Node'
      }.to change(Node, :count).by(1)

      expect(page).to have_content "Node: #{name}"
    end

    it 'Adds a new node w/ parameter', :js => true do
      visit nodes_path
      name = Faker::Lorem.word
      parameter = FactoryGirl.attributes_for(:parameter)

      expect {
        click_link 'Add Node'
        fill_in 'Name', :with => name
        click_link 'Add Parameter'
        fill_in 'key', :with => parameter[:key]
        fill_in 'value', :with => parameter[:value]
        click_button 'Create Node'
      }.to change(Parameter, :count).by(1)

      expect(page).to have_content "Node: #{name}"
    end

    it 'Edits a node', :js => true do
      node = FactoryGirl.create(:node)
      description = Faker::Lorem.word

      visit node_path(node)
      click_link 'Edit'
      fill_in 'Description', :with => description
      click_button 'Update Node'

      click_link 'Edit'
      expect(page).to have_content description
    end

    it 'Deletes a node', :js => true do
      node = FactoryGirl.create(:node)
      visit nodes_path

      within('#nodes') do
        click_link node.name
      end

      expect(page).to have_content "Node: #{node.name}"

      expect {
        click_link 'Delete'
        alert = page.driver.browser.switch_to.alert
        alert.accept
        expect(page).to_not have_content node.name
      }.to change(Node, :count).by(-1)
    end
  end
end
