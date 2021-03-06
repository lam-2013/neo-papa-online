class PostsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def create
    @post = current_user.posts.build(params[:post])

    if @post.save
      flash[:success] = 'Post creato!'
        redirect_to muro_sfogo_url
    else
      @feed_item = []
      render 'pages/wall_outburst'
    end
  end

  def destroy
    @post.destroy
    redirect_to :back
  end

  private

  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_url if @post.nil?
  end

end
