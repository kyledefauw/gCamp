require 'rails_helper'

feature 'Existing users CRUD users' do

  before :each do
    User.destroy_all
  end

  scenario "index lists all users with name, and email" do

    sign_in_user
    expect(current_path).to eq projects_path

    visit users_path
    expect(page).to have_content "Users"
    expect(page).to have_content "Jeff"
    expect(page).to have_content "Austin"
    expect(page).to have_content "jeff@austin.com"
  end

  scenario "can make a new user from the new user form" do

    sign_in_user
    visit (users_path)
    click_link 'New User'

    expect(current_path).to eq new_user_path

    fill_in :user_first_name, with: 'George'
    fill_in :user_last_name, with: 'Jung'
    fill_in :user_email, with: 'george.jung@correction.facility.287.com'
    fill_in :user_password, with: 'cocaine'
    fill_in :user_password_confirmation, with: 'cocaine'

    click_button 'Create User'

    expect(page).to have_content 'george.jung@correction.facility.287.com'
  end

  scenario "index links to show via the name" do

    sign_in_user
    visit users_path

    within('table') do
      click_link 'Jeff'
    end
    expect(page).to have_content 'jeff@austin.com'
  end

  scenario "can edit user" do
    sign_in_user
    visit users_path

    within('table') do
      click_link "Jeff"
    end

    click_link "Edit"

    expect(page).to have_content "Edit User"

    fill_in :user_first_name, with: "Jeff S."
    fill_in :user_password, with: "bringthafunk"
    fill_in :user_password_confirmation, with: "bringthafunk"
    click_button 'Update User'

    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content 'Jeff S.'
  end

  scenario "can delete user from index" do
    user = User.new(first_name: 'George',
    last_name: 'Jung',
    email: 'george.jung@correction.facility.287.com',
    password: 'cocaine',
    password_confirmation: 'cocaine')
    user.save!

    sign_in_user
    visit users_path

    click_on "George"
    click_on "Edit"
    click_on "Delete"

    expect(page).to have_content "User was successfully deleted"
  end

end
