module AnswersHelper

  def current_answer(answer)
    @current_answer = answer
   end
    def question(answer)
      question_id = answer.question_id
      @q = Question.find_by_id(question_id)
    end

  def user(answer)
    question_id = answer.question_id
    q = Question.find_by_id(question_id)
    user_id = q.user_id
    @u = User.find_by_id(user_id)
  end


end
