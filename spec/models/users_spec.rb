require 'rails_helper'


  describe User do
    it "requires a first name" do
      user = User.new
      expect(user).not_to be_valid
      user.update(first_name: "Kyle", last_name: "DeFauw", email: "kyle@defauw.com", password: 'coding', password_confirmation: 'coding')
      expect(user).to be_valid
    end
  end
