require 'rails_helper'

RSpec.feature "Articles", type: :feature do
  describe 'add a new article' do
    before do
      Category.create(name: 'Movies', priority: 1)
      User.create(name: 'Gui')
    end

    it 'logs in and creates an article' do
      visit root_path
      click_on 'LOG IN'
      fill_in 'name', with: 'Gui'
      click_on 'Log in'
      click_link('WRITE AN ARTICLE')

      expect(page).to have_content('Write Your Article')

      fill_in('article[title]', with: 'Harry Potter')
      sleep(2)
      fill_in('article[text]', with: 'Cool new Harry Potter book')
      sleep(2)
      find('form input[type="file"]').set('./spec/picture/harry.jpeg')
      sleep(2)
      click_button('Create article')
      sleep(2)

      expect(page).to have_content('Cool new Harry Potter book')
    end
  end
end
