class AgeGroupsController < ApplicationController

  def show
    #vista show: cerco la categoria, riempio un array con le domande relative a quella categoria
    @age_group_current = AgeGroup.find(params[:id])
    @questions = @age_group_current.questions.paginate(page: params[:page])

    #carica tutte le categorie
    @category = Category.all

    #carica tutte le fasce d'età
    @age_group = AgeGroup.all
  end

end
