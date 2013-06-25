class PagesController < ApplicationController


  def about
  end

  def contact
  end

  def eventi
  end

  def informazioni_profilo
  end

  def wall_outburst
    @post = current_user.posts.build if signed_in?
    @feed_items = Post.paginate(page: params[:page])
  end


end
