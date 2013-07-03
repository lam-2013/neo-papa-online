class LikeAnswersController < ApplicationController

  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @answer = Answer.find(params[:like_answer][:answer_id])
    current_user.like_answers!(@answer)
    respond_with @answer
  end

  def destroy
    @answer = LikeAnswer.find(params[:id]).answer
    current_user.dont_like_answers!(@answer)
    respond_with @answer
  end

end
