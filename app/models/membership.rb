class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  enum role: {member: 0, owner: 1}

end
