class CategoriesController < ApplicationController


  def show
    #vista show: cerco la categoria, riempio un array con le domande relative a quella categoria
    @cat_current = Category.find(params[:id])
    @questions = @cat_current.questions.paginate(page: params[:page])

    #carica tutte le categorie
    @category = Category.all

    @age_group = AgeGroup.all
  end
end
