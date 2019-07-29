class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article created";
      redirect_to article_path
    else
      render 'articles/new'
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
