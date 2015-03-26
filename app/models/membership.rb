class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  enum role: {Member: 0, Owner: 1}

  validates :user, :presence => true
  validates :user, uniqueness: {scope: :project_id, message: 'has already been added to this project'}
end
