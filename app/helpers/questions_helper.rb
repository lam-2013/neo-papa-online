module QuestionsHelper

  def category_name(question)
    category_id = question.category_id
    category = Category.find_by_id(category_id)
    @category_name = category.title
  end


end
