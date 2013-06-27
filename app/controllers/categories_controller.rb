class CategoriesController < ApplicationController

  def show


    @cat_current = Category.find(params[:id])
    @questions = @cat_current.questions.paginate(page:params[:page])
    @category = Category.paginate(page: params[:page])

  end
end
