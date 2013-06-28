class PagesController < ApplicationController

  def about
  end

  def contact
  end

  def eventi
  end

  def wall_outburst
    @post = current_user.posts.build if signed_in?
    @sfogo_items = Post.todays_post.paginate(page: params[:page])
  end
end
