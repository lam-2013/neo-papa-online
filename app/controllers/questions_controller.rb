class QuestionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
    @question = Question.new
  end

  def show
    @question = Question.find_by_id(params[:id])
    @category = Category.all
    @age_group = AgeGroup.all

    @answer = current_user.answers.build if signed_in?
    @answers = @question.answers.paginate(page: params[:page])

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

  #TO DO: da controllare non funziona
  def destroy
    @question.destroy
    redirect_to question_path
  end


  #TO DO
  def edit
  end

  #TO DO
  def update
  end

  def index
    @questions = Question.paginate(page: params[:page])
    @category = Category.all
    @age_group = AgeGroup.all
  end

  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end

end
