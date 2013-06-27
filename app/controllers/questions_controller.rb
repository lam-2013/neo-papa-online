class QuestionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
    @question = Question.new
  end

  def show
    @question = Question.find_by_id(params[:id])
    @category = Category.paginate(page: params[:page])

    @answer = current_user.answers.build if signed_in?
    @answers = Answer.paginate(page: params[:page])

  end

  def create

    @question = current_user.questions.build(params[:question])

    if @question.save
      flash[:success] = 'Domanda inserita con successo'
      redirect_to questions_path
    else
      @query_items = []
      render 'new'
    end
  end

  def destroy
    @question.destroy
    redirect_to current_user
  end

  def edit
  end

  def update
  end

  def index
    @questions = Question.paginate(page: params[:page])
    @category = Category.paginate(page: params[:page])
  end

  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end

end
