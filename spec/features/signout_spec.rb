require 'rails_helper'

  feature "sign-out" do

  before :each do
    User.destroy_all
  end

    scenario 'user can sign out' do
      sign_in_user

      expect(page).to have_content "Jeff Austin"

      click_on "Sign Out"

      expect(page).to have_content "Sign In"
      expect(current_path).to eq root_path
    end
end
