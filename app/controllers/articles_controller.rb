class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @article = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    #debugger
    @article = Article.new(article_params)
    @article.user = current_user
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
    flash[:danger] = "Article deleted"
    redirect_to articles_path
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can delete own articles"
      redirect_to root_path
    end
  end

end
