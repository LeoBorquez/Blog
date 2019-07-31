class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article created"
      redirect_to @article
    else
      render 'articles/new'
    end
  end

  def show

  end

  def edit

  end

  def update

    if @article.update(article_params)
      flash[:success] = "Article updated"
      redirect_to @article
    else
      render 'articles/edit'
    end
  end

  def destroy

    @article.destroy
    flash[:success] = "Article deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end
