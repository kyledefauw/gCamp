class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, :email, :presence => true
  validates :email, :uniqueness => true
  validates :password, :presence => true,
                     :confirmation => true,
                     :length => {:within => 6..40},
                     :on => :create
  validates :password, :confirmation => true,
                       :length => {:within => 6..40},
                       :allow_blank => true,
                       :on => :update

  def full_name
    "#{first_name} #{last_name}"
  end

end
