class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
	validates :password, length: { minimum: 6 }

  has_many :drinks

  def self.is_existing_email(email)
  	if User.find_by(email: email).nil?
  		false
		else
      true
  	end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

	def User.encrypt(token)
	    Digest::SHA1.hexdigest(token.to_s)
	end

	def self.update_accnt_with_fb_attr(email,auth)
  	u = User.find_by(email: email)
  	u.update_attribute :name, auth.info.name
  	u.update_attribute :uid, auth.uid
  	u.update_attribute :location, auth.location
  	u.update_attribute :oauth_token, auth.credentials.token
  	u.update_attribute :provider, auth.provider
  end

  #will either return the first matching record or initialize a new
	#record with the parameters that were passed in
	def self.from_omniauth(auth)
  	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|

  		if User.is_existing_email(auth.info.email)
  			self.update_accnt_with_fb_attr(auth.info.email,auth)
  		else
    		user.name = auth.info.name
		    user.email = auth.info.email
		    user.password = auth.uid
		    user.password_confirmation = auth.uid
		    user.uid = auth.uid
		    user.location = auth.info.location
		    user.oauth_token = auth.credentials.token
		    user.provider = auth.provider
        user.picture = auth.info.image
		    user.save!
		  end
  	end
	end

	private
	  def create_remember_token
	    self.remember_token = User.encrypt(User.new_remember_token)
	  end
end
