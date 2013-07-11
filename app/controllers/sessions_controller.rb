class SessionsController < ApplicationController

  def new
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
    @query_items = current_user.query.paginate(page: params[:page]) if signed_in?
    @answer_items = current_user.answers.paginate(page: params[:page]) if signed_in?
    @category = Category.where("waiting = 't' and accepted = 'f'")
  end


  def create
    user = User.find_by_email(params[:session][:email].downcase)

    if user  && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
