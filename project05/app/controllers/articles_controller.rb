class ArticlesController < ApplicationController
	respond_to :html
	before_filter except: [:index, :create] do
		@article = Article.find_or_initialize_by_id params[:id]
	end

	def index
      @articles = Article.paginate page: params[:page]
	end
	
	def show
	end

	def new
	end

	def create
		if (@article = Article.new(params[:article])).save
			redirect_to @article, notice: "Article \"#{@article.title}\" successfully created!"
		else
			render :edit
		end
	end

	def edit
		session[:previous_page] = request.referer || article_url(@article)
	end

	def update
		if @article.update_attributes(params[:article])
			redirect_to session[:previous_page], notice: "Article \"#{@article.title}\" successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_url, notice: "Article \"#{@article.title}\" successfully purged!" 
	end
end
