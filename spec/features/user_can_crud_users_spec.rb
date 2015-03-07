require "rails_helper"

  feature "User can Create, Read, Update and Delete users with flash messages" do

    before do
      sign_in
    end

    scenario "User can create users with flash messages" do
      visit users_path
      click_on 'New User'
      within("form") { click_on 'Create User'}
      expect(page).to have_content("can\'t be blank")

      fill_in 'First name', with: 'Keller'
      fill_in 'Last name', with: 'Williams'
      fill_in 'Email', with: 'keller@kellerwilliams.net'
      fill_in 'Password', with: 'freaker'
      fill_in 'Password confirmation', with: 'freaker'
      click_on 'Create User'

      expect(page).to have_content "Keller Williams"
      expect(page).to have_content "User was successfully created"
    end

    scenario "User can read users with flash messages" do
      visit user_path(@user1)

      expect(page).to have_content 'Jeff'
      expect(page).to have_content 'jeff@austin.com'
    end

    scenario "User can update users with flash messages" do
      visit user_path(@user1)
      click_on 'Edit'
      fill_in 'Email', with: 'jeff.austin@gmail.com'
      click_on 'Update User'
      expect(page).to have_content('User was successfully updated')
      expect(page).to have_content('jeff.austin@gmail.com')
    end

    scenario "User can delete users with flash messages" do
      visit users_path
      click_on "Edit"
      click_on 'Delete'

      expect(page).not_to have_content "jeff@austin.com"
    end
  end

  feature "User can see at least one validation message displayed" do
    scenario "validation message pops up when no data is filled in" do
      visit new_user_path
        fill_in "First name", with: 'Sweet!'
        click_on 'Create User'
        expect(page).to have_content("name can\'t be blank")
    end
  end
