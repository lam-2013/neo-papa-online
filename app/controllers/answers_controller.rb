class AnswersController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def create

    @answer = Answer.create(:user_id => current_user.id, :question_id => '3', :content => 'fff')

    if @answer.save
      flash[:success] = 'Risposta creata!'
      redirect_to :back
    else
      redirect_to root_url
    end

  end

  def destroy
    @answer.destroy
    redirect_to question_path
  end

  private

  def correct_user
    @answer = current_user.answers.find_by_id(params[:id])
    redirect_to root_url if @answer.nil?
  end

end
