class AnswersController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

 def create
   @answer = current_user.answers.build(params[:answer])

    if @answer.save
      flash[:success] = 'Risposta creata!'
      redirect_to :back
    else
      redirect_to root_url
    end

  end

  def destroy
    @answer.destroy
    redirect_to :back
  end

  private

  def correct_user
    @answer = current_user.answers.find_by_id(params[:id])
    redirect_to root_url if @answer.nil?
  end

end
