class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  validates :name,  presence: true,
                    length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }


  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, remember_token)
  end

  def authenticated?(remember_token)
    remember_digest == remember_token
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def cart_count
    $redis.scard "cart#{id}"
  end
end
