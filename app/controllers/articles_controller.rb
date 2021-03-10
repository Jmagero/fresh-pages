class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @categories = Category.all
  end

  def index
    category = Category.find(params[:format])
    @articles = category.latest_articles.includes(article_categories: :article)
  end

  def create
    user = User.find_user(session[:user_id])
    @article = user.take.articles.new(article_params)
    if @article.valid?
      @article.article_categories.build(category_id: category_params[:id]).save
      @article.save

      redirect_to @article, notice: 'Article created!'
    else

      redirect_to new_article_path, alert: @article.errors.full_messages.to_s
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
    redirect_to @article, notice: "You can't edit this" if restrict_article_access
    @categories = Category.all
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = 'Article updated'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    if @article
      @article.destroy
      flash[:success] = 'Article has been deleted'
    else
      flash[:alert] = 'Error'
    end
    redirect_to root_path
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :image)
  end

  def category_params
    params.require(:category).permit(:id)
  end
end
