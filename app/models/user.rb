class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, :email, :presence => true
  validates :email, :uniqueness => true

  has_many :comments, dependent: :nullify
  has_many :projects, through: :memberships
  has_many :memberships, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def token_privacy
    first_four = pivotal_token[0,4]
    first_four + ('*'*(pivotal_token.delete first_four).length)
    # self.pivotal_token[0..3] + ('*'*(self.pivotal_token.length - 4))
  end

end
