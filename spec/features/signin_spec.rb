require "rails_helper"

feature "sign in" do

  before :each do
    User.destroy_all
  end

  scenario "can sign in" do

    user = User.new(first_name: 'Fred',
    last_name: 'Flintstone',
    email: 'fred@flintstone.com',
    password: 'yabadaba',
    password_confirmation: 'yabadaba')
    user.save!

    visit root_path
    click_on "Sign In"

    expect(page).to have_content "Sign into gCamp"

    fill_in 'Email', with: 'fred@flintstone.com'
    fill_in 'Password', with: 'yabadaba'
    within('form') do
      click_on "Sign In"
    end

    expect(current_path).to eq projects_path

end

scenario 'are redirected back to the sign in form and shown a flash error if no such user exists' do
  visit root_path
  click_on 'Sign In'

  expect(current_path).to eq sign_in_path
  expect(page).to have_content 'Sign into gCamp'

  fill_in :email, with: 'spider@man.com'
  fill_in :password, with: 'web'
  click_button 'Sign In'

  expect(current_path).to eq sign_in_path
  expect(page).to have_content 'Email / Password combination is invalid'
  end
end
