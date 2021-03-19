require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'Navigate the webpage' do
    it 'creates a new user and logs in' do
      visit new_user_path
      fill_in 'Name', with: 'Gui2'
      click_on 'Register'
      expect(page).to have_content('Welcome to Fresh pages')
      sleep(3)
      click_on 'LOG IN'
      fill_in 'Name', with: 'Gui2'
      click_on 'Log in'
      expect(page).to have_content('WRITE AN ARTICLE')
    end
  end
end
