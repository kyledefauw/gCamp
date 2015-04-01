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
    self.pivotal_token[0..3] + ('*'*(self.pivotal_token.length - 4))
  end

end
