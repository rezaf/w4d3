class User < ActiveRecord::Base
  
  attr_reader :password
  
  validates :user_name, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  after_initialize :ensure_session_token
  
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def password_digest
    BCrypt::Password.new(super)
  end
  
  def is_password?(password)
    self.password_digest.is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    
    return nil if user.nil?
    
    user.password_digest.is_password?(password) ? user : nil
  end
  
end