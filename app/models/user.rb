class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  has_many :drinks, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  has_many :cocktail_like_relationships, foreign_key: "user_id", dependent: :destroy
  has_many :beer_like_relationships, foreign_key: "user_id", dependent: :destroy
  has_many :venue_like_relationships, foreign_key: "user_id", dependent: :destroy
  
  has_many :liked_cocktails, through: :cocktail_like_relationships, source: :cocktail
  has_many :liked_beers, through: :beer_like_relationships, source: :beer
  has_many :liked_venues, through: :venue_like_relationships, source: :venue


  def cocktails
    return self.drinks.where(type: "Cocktail").pluck(:name).uniq
  end

  def beers
    return self.drinks.where(type: "Beer").pluck(:name).uniq
  end

  def cocktail_types
    @cocktails = self.cocktails
    @cocktail_types = []
    @cocktails.each do |cocktail|
      style = Cocktail.find_by(name: cocktail).primary
      @cocktail_types.push(style) unless @cocktail_types.include?(style)
    end
    return @cocktail_types
  end

  def beer_types
    @beers = self.beers
    @beer_types = []
    @beers.each do |beer|
      style = Beer.find_by(name: beer).style
      @beer_types.push(style) unless @beer_types.include?(style)
    end
    return @beer_types
  end

  def uniq_drink_count
    return self.cocktails.count + self.beers.count
  end

  def checkins_count
    @checkins = 0
    self.drinks.each do |drink|
      if !drink.venue.nil?
        @checkins = @checkins+1
      end
    end
    return @checkins
  end

  def venues
    @venues = []
    Venue.all.each do |venue|
      venue.drinks.where(user_id: self.id).each do |match|
        @venues.push(venue) if !@venues.include?(venue)
      end
    end
    return @venues.reverse!
  end

  def level
    if self.drinks.count >= 350 && self.uniq_drink_count >= 200
      return 14
    elsif self.drinks.count >= 275 && self.uniq_drink_count >= 180
      return 13
    elsif self.drinks.count >= 200 && self.uniq_drink_count >= 150
      return 12
    elsif self.drinks.count >= 150 && self.uniq_drink_count >= 100
      return 11
    elsif self.drinks.count >= 125 && self.uniq_drink_count >= 80
      return 10
    elsif self.drinks.count >= 100 && self.uniq_drink_count >= 75
      return 9
    elsif self.drinks.count >= 75 && self.uniq_drink_count >= 40
      return 8
    elsif self.drinks.count >= 50 && self.uniq_drink_count >= 30
      return 7
    elsif self.drinks.count >= 35 && self.uniq_drink_count >= 20
      return 4
    elsif self.drinks.count >= 25 && self.uniq_drink_count >= 15
      return 5
    elsif self.drinks.count >= 15 && self.uniq_drink_count >= 10
      return 4
    elsif self.drinks.count >= 10 && self.uniq_drink_count >= 6
      return 3
    elsif self.drinks.count >= 5 && self.uniq_drink_count >= 3
      return 2
    elsif self.drinks.count > 0
      return 1
    else
      return 0
    end
  end

  def fly_status
    if self.drinks.count >= 350 && self.uniq_drink_count >= 200
      return 'BarFly'
    elsif self.drinks.count >= 275 && self.uniq_drink_count >= 180
      return 'PubFly'
    elsif self.drinks.count >= 200 && self.uniq_drink_count >= 150
      return 'WineFly'
    elsif self.drinks.count >= 150 && self.uniq_drink_count >= 100
      return 'BeerFly'
    elsif self.drinks.count >= 125 && self.uniq_drink_count >= 80
      return 'CorkFly'
    elsif self.drinks.count >= 100 && self.uniq_drink_count >= 75
      return 'AleFly'
    elsif self.drinks.count >= 75 && self.uniq_drink_count >= 40
      return 'TapFly'
    elsif self.drinks.count >= 50 && self.uniq_drink_count >= 30
      return 'BottleFly'
    elsif self.drinks.count >= 35 && self.uniq_drink_count >= 20
      return 'FleshFly'
    elsif self.drinks.count >= 25 && self.uniq_drink_count >= 15
      return 'CraneFly'
    elsif self.drinks.count >= 15 && self.uniq_drink_count >= 10
      return 'HorseFly'
    elsif self.drinks.count >= 10 && self.uniq_drink_count >= 6
      return 'DrainFly'
    elsif self.drinks.count >= 5 && self.uniq_drink_count >= 3
      return 'FruitFly'
    elsif self.drinks.count > 0
      return 'Gnat'
    else
      return 'Newbie'
    end
  end

  def feed
    Drink.from_users_followed_by(self)
  end

  def feed_all
    Drink.all
  end

  def feed_local
    Drink.where(location: self.location)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def like_venue?(venue)
    venue_like_relationships.find_by(venue_id: venue.id)
  end

  def like_venue!(venue)
    venue_like_relationships.create!(venue_id: venue.id)
    if venue.likes.nil?
      likes = 1
    else
      likes = venue.likes + 1
    end
    venue.update_attribute(:likes, likes)
  end

  def unlike_venue!(venue)
    venue_like_relationships.find_by(venue_id: venue.id).destroy
    likes = venue.likes - 1
    venue.update_attribute(:likes, likes)
  end

  def like_cocktail?(cocktail)
    cocktail_like_relationships.find_by(cocktail: cocktail.id)
  end

  def like_cocktail!(cocktail)
    cocktail_like_relationships.create!(cocktail_id: cocktail.id)
    if cocktail.likes.nil?
      likes = 1
    else
      likes = cocktail.likes + 1
    end
    cocktail.update_attribute(:likes, likes)
  end

  def unlike_cocktail!(cocktail)
    cocktail_like_relationships.find_by(cocktail_id: cocktail.id).destroy
    likes = cocktail.likes - 1
    cocktail.update_attribute(:likes, likes)
  end

  def like_beer?(beer)
    beer_like_relationships.find_by(beer_id: beer.id)
  end

  def like_beer!(beer)
    beer_like_relationships.create!(beer_id: beer.id)
    if beer.likes.nil?
      likes = 1
    else
      likes = beer.likes + 1
    end
    beer.update_attribute(:likes, likes)
  end

  def unlike_beer!(beer)
    beer_like_relationships.find_by(beer_id: beer.id).destroy
    likes = beer.likes - 1
    beer.update_attribute(:likes, likes)
  end

  def self.is_existing_email(email)
  	if User.find_by(email: email).nil?
  		false
		else
      true
  	end
  end

  def first_visited_instance(venue)
    venue.drinks.where(user_id: self.id).last
  end

  def times_visited(venue)
    venue.drinks.where(user_id: self.id).count
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
        location = auth.info.location.to_s
        city_state = location.split(",")
        state = LocationCache.state_code(city_state[1].squish)
		    user.location = city_state[0].squish+", "+state
		    user.oauth_token = auth.credentials.token
		    user.provider = auth.provider
        user.picture = "http://graph.facebook.com/"+auth.uid+"/picture?width=300&height=300"
		    user.save!
		  end
  	end
	end

	private
	  def create_remember_token
	    self.remember_token = User.encrypt(User.new_remember_token)
	  end
end
