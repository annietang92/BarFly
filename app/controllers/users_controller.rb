class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:show, :index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 8)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 8)
    render 'show_follow'
  end

  def show
    @profile = true
    @user = User.find(params[:id])
    @feed_items = @user.drinks.paginate(page: params[:page], :per_page => 20)

    if @user.provider == "facebook"
      @facebook_auth = true
    else
      @facebook_auth = false
    end  
  end

  def new
    @user = User.new
    @locations = LocationCache.last.text
  end

  def edit
    @user = User.find(params[:id])
    @locations = LocationCache.last.text
  end

  def update
    if user_params.include?(:feed_preference)
      no_flash = true
    end
    @user = User.find(params[:id])
    @locations = LocationCache.last.text
    if @user.update_attributes(user_params)
      if !no_flash
        flash[:success] = "Profile updated"
      end
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    @user.picture = "Icons/icon_final.png"
    @user.feed_preference = "Local"
    if @user.save
      sign_in @user
      flash[:success] = "Hello! Welcome to BarFly!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :location, :password,
                                   :password_confirmation, :feed_preference)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end