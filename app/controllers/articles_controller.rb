class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  before_action :authorize_admin, only: [:edit, :update, :set_state, :update_state]


  def index
    if params[:state].present? && %w[active pending].include?(params[:state])
      @articles = Article.where(state: params[:state])
    else
      @articles = Article.all
    end
    @article_count = @articles.count
  end

  def show
    @article = Article.find(params[:id])
  end

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

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def set_state
    @article = Article.find(params[:id])
  end
  
  def update_state
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: 'Article state was successfully updated.'
    else
      render :set_state, status: :unprocessable_entity
    end
  end
   
  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :state)
    end

    def authorize_admin
      return if current_user&.has_role?('Admin')
      flash[:alert] = "Unauthorized access."
      redirect_to root_path
    end
end
