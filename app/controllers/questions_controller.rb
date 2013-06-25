class QuestionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new

    @query_items = current_user.query.paginate(page: params[:page]) if signed_in?

  end

  def show
  end

  def create

    @question = Question.new
    @question.user_id = current_user
    @question.title = params[:question][:title]
    @question.category_id = params[:question][:category_id]
    @question.age = params[:question][:age]
    @question.content = params[:question][:content]

    if @question.save
      flash[:success] = 'Domanda salvata!'
      redirect_to root_url
    else
      render 'sessions/new'
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
  end


  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end

end
