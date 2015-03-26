class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :message, :presence => true
end
