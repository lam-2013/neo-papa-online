class LikeQuestionsController < ApplicationController

  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @question = Question.find(params[:like_question][:question_id])
    current_user.like_questions!(@question)
    respond_with @question
  end

  def destroy
    @question = LikeQuestion.find(params[:id]).question
    current_user.dont_like_questions!(@question)
    respond_with @question
  end

end


