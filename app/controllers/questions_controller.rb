class QuestionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
    @question = Question.new

    @category = Category.where("waiting = 'f' and accepted = 't'")
    @age_groups = AgeGroup.all

  end

  def show

    @question = Question.find_by_id(params[:id])
    @category = Category.where("waiting = 'f' and accepted = 't'")
    @age_group = AgeGroup.all

    @answer = current_user.answers.build if signed_in?
    @answers = @question.answers.paginate(page: params[:page])

  end

  def create

    @question = current_user.questions.build(params[:question])

    if params[:preview_button] || !@question.save
      @query_items = []
      render 'questions/new'

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
    @category = Category.where("waiting = 'f' and accepted = 't'")
    @age_group = AgeGroup.all
     @like = 0

    @questions2 = current_user.questions.all
    @q_like = LikeQuestion.all

    @q_like.each { |q_like| @questions2.each{ |questions2| if questions2.id == q_like.question_id
                                                                  @like = @like+1
                                                                  end}}
  end


  def home
    @questions = Question.all(limit: 10)
    @category = Category.where("waiting = 'f' and accepted = 't'")
    @age_group = AgeGroup.all
  end


  def search
    @questions = Question.search(params[:category_id], params[:age_group_id]).paginate(page: params[:page])

    @category = Category.where("waiting = 'f' and accepted = 't'")
    @age_group = AgeGroup.all
  end



  private

  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end
end
