class CategoriesController < ApplicationController

  def show

    @category = Category.paginate(page: params[:page])
    @cat_current = Category.find(params[:id])
    @cat = @cat_current.id
    @questions = Question.find_by_category_id(@cat).paginate(page: params[:page])
    #@query = Question.find_by_category_id(@cat).paginate(page: params[:page])
  end
end
