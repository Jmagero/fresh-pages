class ArticlesController < ApplicationController
    include ApplicationHelper
    include SessionsHelper
    before_action :logged_in_user

    def home
    end
    def new
        @article = current_user.articles.new
    end

    def index
        @articles = Article.all
    end

    def create
        @article = current_user.articles.find_by(article_params)
        if @article.save
            flash[:success]="You have create new article"
            redirect_to @article
        else
            render 'new'
        end
    end

    def edit
        @article = current_user.articles.find(params[:id])
    end

    def update
        @article = current_user.articles.find(params[:id])
        if @article.update_attributes(article_params)
            flash[:success] = "Article updated"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = current_user.articles.find(params[:id])
        if @article
            @article.destroy
            flash[:success]= "Article has been deleted"
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
        params.require(article).permit(:title,:text,:image_data)
    end
end
