class QuestionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
    @question = Question.new
  end

  def show
    @query_items = current_user.query.paginate(page: params[:page]) if signed_in?
    @category = Category.paginate(page: params[:page])
    @question = current_user.questions.build if signed_in?

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
  end

  def my_questions
    @user = User.find(params[:id])
    @questions = @user.questions.paginate(page: params[:page])
  end


  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end

end
