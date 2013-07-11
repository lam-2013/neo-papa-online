module AnswersHelper

  #per estrapolare la domanda a cui è stata aggiunta la risposta
  def current_answer(answer)
    @current_answer = answer
   end
    def question(answer)
      question_id = answer.question_id
      @q = Question.find_by_id(question_id)
    end

  #per prendere l'utente che ha scritto la domanda a cui è stata data la risposta
  def user(answer)
    question_id = answer.question_id
    q = Question.find_by_id(question_id)
    user_id = q.user_id
    @u = User.find_by_id(user_id)
  end
end
