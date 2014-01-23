class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def index
  	@users = User.paginate(page: params[:page], :per_page => 5)
  end

  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @locations = LocationCache.last.text
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :location, :password,
                                   :password_confirmation)
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