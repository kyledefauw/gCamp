require "rails_helper"

  feature "User can Create, Read, Update and Delete Users with flash messages"  do
    scenario "User can create users with flash messages" do
      visit('/users')
      click_botton('New User')
      fill_in('Description', with: 'Get to work')
      fill_in('Date', with: '09/06/1991')
      check('Complete')
    end

    scenario "User can read users with flash messages" do
      visit('user_path(user)')

    end

    scenario "User can update users with flash messages" do
      visit('/users')
      click_botton('Edit')

    end

    scenario "User can delete users with flash messages" do
      visit('/users')
      click_botton('Delete')

    end

  feature "User can see at least one validation message displayed" do
    scenario "validation message pops up when no data is filled in" do
      visit('/users')
      click_botton('Edit')

    end
  end

  feature "Model testing - users are not valid without a description" do
    scenario "fill in user without a description" do

    end
  end

end
