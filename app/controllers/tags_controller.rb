class TagsController < ApplicationController

  def create

    @tag = Tag.new(params[:tag])

    if @tag.save
      redirect_to root_path
    else
      render 'new'
    end
  end


end
