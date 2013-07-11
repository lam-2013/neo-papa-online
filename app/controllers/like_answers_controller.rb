class LikeAnswersController < ApplicationController

  before_filter :signed_in_user

  def create
    @like_answer = current_user.like_answers.build(params[:like_answer])

    if @like_answer.save
      redirect_to :back
    else
      render 'questions/show'
    end
  end

  def destroy
    @like_answer = LikeAnswer.find(params[:id])
    @like_answer.destroy
    redirect_to :back
  end
end
