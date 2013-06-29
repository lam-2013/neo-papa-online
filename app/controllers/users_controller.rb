class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy, :messages]
  before_filter :correct_user, only: [:edit, :update, :messages]
  before_filter :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @posts= @user.posts.paginate(page: params[:page])
    @questions = @user.questions.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = 'Benvenuto in New Dad'
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end


  def edit
  end

  def update
    if @user.update_attributes(params[:user])

      flash[:success] = 'Profilo aggiornato'
      sign_in @user
      redirect_to informazioni_profilo_user_path(current_user)
    else

      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Utente cancellato!'
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def friends
    @title = 'Amici'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @users2 = @user.followed_users.paginate(page: params[:page])
    render 'friends'
  end

  def search
    @users = User.search(params[:search]).paginate(page: params[:page])
  end

  def messages
    @user = User.find(params[:id])
    @messages = @user.received_messages.paginate(page: params[:page])
  end

  def my_questions
    @user = User.find(params[:id])
    @questions = @user.questions.paginate(page: params[:page])
    @category = Category.all
    @age_group = AgeGroup.all
  end


  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) # the current_user?(user) method is defined in the SessionsHelper
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end
