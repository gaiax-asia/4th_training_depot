class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password
  #acts_as_url :generate_url
  
  after_destroy :ensure_an_admin_user_remains
  #
  # def to_param
  #   url
  # end
  #
  # def generate_url
  #   "#{id}-#{name}"
  # end
  #
  private
  def ensure_an_admin_user_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
