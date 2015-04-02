require 'rails_helper'

feature 'user signup' do

  before :each do
    User.destroy_all
  end

  scenario 'user can sign up' do
    visit root_path
    expect(page).to have_content 'gCamp'

    click_link 'Sign Up'
    expect(current_path).to eq sign_up_path
    expect(page).to have_content 'Sign up for gCamp!'

    fill_in :user_first_name, with: 'Ralph'
    fill_in :user_last_name, with: 'Nader'
    fill_in :user_email, with: 'ralph@nader.com'
    fill_in :user_password, with: 'hi'
    fill_in :user_password_confirmation, with: 'hi'
    click_button 'Sign Up'

    expect(current_path).to eq new_project_path
    expect(page).to have_content 'You have successfully signed up'
  end
end
