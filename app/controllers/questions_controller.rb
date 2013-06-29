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

    @question = Question.find(params[:id])
    @answers = @question.answers.all

    @answers.each { @question.answers.destroy}
    @question.destroy

    flash[:success] = 'Domanda e relative risposte cancellate!'

    redirect_to questions_url

  end


  def edit
  end

  def update

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

  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end
end
