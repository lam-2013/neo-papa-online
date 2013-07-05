class CategoriesController < ApplicationController

  def show
    #vista show: cerco la categoria, riempio un array con le domande relative a quella categoria
    @cat_current = Category.find(params[:id])
    @questions = @cat_current.questions.paginate(page: params[:page])

    #carica tutte le categorie
    @category = Category.all

    @age_group = AgeGroup.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(params[:category])

    if current_user.admin?
      # l'utente che sta creando la nuova categoria è l'amministratore
      @category.toggle!(:waiting)
      @category.toggle!(:accepted)

      if @category.save
        flash[:success] = 'Categoria aggiunta con successo'
        redirect_to questions_url
      else
        #l'utente non è l'amministratore, la nuova categoria per essere visualizzata da tutti deve essere accettata dall'amministratore
        render 'new'
      end
    else

      if @category.save
        flash[:success] = 'Nuova categoria creata e in attesa di essere accettata dall\'amministratore'
        redirect_to questions_url
      else
        render 'new'
      end

    end

  end

  def edit
    @category = Category.find(params[:id])
  end

  def update

     @category = Category.find(params[:id])

     @category.toggle!(:waiting)
     @category.toggle!(:accepted)

     if @category.update_attributes(params[:category])

       flash[:success] = 'Categoria aggiornata e visibile a tutti'
       redirect_to questions_url
     else
       render 'edit'
     end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'Categoria cancellata!'
    redirect_to root_path
  end


end
