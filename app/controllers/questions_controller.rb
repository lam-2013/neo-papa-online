class QuestionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
    @question = Question.new

    @categories = Category.all
    @age_groups = AgeGroup.all

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

    if params[:preview_button] || !@question.save
      @query_items = []
      render 'new'

    else
      flash[:success] = 'Domanda inserita con successo'
      redirect_to questions_path
    end
  end

 #seleziono la domanda corrente e le risposte di quella domanda
  #cancello prima tutte le risposte e poi la domanda
  def destroy

    @question = Question.find(params[:id])
    @answers = @question.answers.all

    @answers.each { @question.answers.destroy}
    @question.destroy

    flash[:success] = 'Domanda e relative risposte cancellate!'

    redirect_to questions_url

  end


  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:success] = 'Domanda aggiornata'
      redirect_to question_path
    else
      render 'edit'
    end

  end

  def index
    @questions = Question.paginate(page: params[:page])
    @category = Category.all
    @age_group = AgeGroup.all
  end

  def home
    @questions = Question.all(limit: 10)
    @category = Category.all
    @age_group = AgeGroup.all
  end

  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end
end
