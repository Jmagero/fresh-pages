require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'Navigate the webpage' do
    it 'creates a new user and logs in' do
      visit new_user_path
      fill_in 'Name', with: 'Gui2'
      click_on 'Register'
      expect(page).to have_content('Gui2 you were successfully created')
    end

    it 'does not login user with blank username' do
      visit login_path
      fill_in 'Name', with: 'Gui2'
      click_on 'LOG IN'
      fill_in 'Name', with: ' '
      click_on 'Log in'
      expect(page).to have_content('Invalid user')
    end

    it 'does not login user with invalid username' do
      visit login_path
      fill_in 'Name', with: 'Gui2'
      click_on 'LOG IN'
      fill_in 'Name', with: 'Norah'
      click_on 'Log in'
      expect(page).to have_content('Invalid user')
    end

  end
end
