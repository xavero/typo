class Admin::CategoriesController < Admin::BaseController
  #cache_sweeper :blog_sweeper

  def index; redirect_to :action => 'new' ; end
  #def index
  #  @categories = Category.order('name')
  #end
  
  def edit
    id = params[:id]
    if not id 
      #redirect_to :action => 'new'
      @category = Category.new
    else
      @category = Category.find(params[:id])
    end
    new_or_edit
  end

  def new 
    @category = Category.new    
    respond_to do |format|
      format.html { new_or_edit }
      format.js { @category }
    end
  end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  private

  def new_or_edit
    @categories = Category.find(:all)
    #@category = Category.find(params[:id])
    @category.attributes = params[:category]
    if request.post?
      respond_to do |format|
        format.html { save_category }
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
      return
    end
    render 'new'
  end

  def save_category
    if @category.save!
      flash[:notice] = _('Category was successfully saved.')
    else
      flash[:error] = _('Category could not be saved.')
    end
    redirect_to :action => 'new'
  end

end
