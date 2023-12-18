class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all unless Article.states.key?(params[:state])
    @articles ||= Article.send(params[:state])
    @article_count = @articles.count
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :state)
    end

    def find_article
      @article = Article.find_by(id: params[:id])

      unless @article
        flash[:alert] = "Article not found!"
        redirect_to root_path
      end
    end
end
