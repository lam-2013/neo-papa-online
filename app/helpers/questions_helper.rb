module QuestionsHelper


  # data una domanda estrae il nome della categoria a cui appartiene
  def category_name(question)
    category_id = question.category_id
    category = Category.find_by_id(category_id)
    @category_name = category.title
  end

  def age_groups_name(question)
    age_group_id = question.age_group_id
    age_group = AgeGroup.find_by_id(age_group_id)
    @age_group_name = age_group.name
  end

end
