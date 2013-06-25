module QuestionsHelper

  def category_name(question)
    category_id = question.category_id
    category = Category.find_by_id(category_id)
    @category_name = category.title
  end

  def today(question)
    date_q = question.created_at
    d = date_q.strftime("%Y-%m-%d")

    if d == Date.current.strftime("%Y-%m-%d")
      @ok = 'ok'
    else
      @no = 'no'
    end

  end

end
