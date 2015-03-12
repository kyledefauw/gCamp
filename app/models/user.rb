class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, :email, :presence => true
  validates :email, :uniqueness => true

  has_many :memberships
  has_many :comments
  has_many :projects


  def full_name
    "#{first_name} #{last_name}"
  end

end
