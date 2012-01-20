class ArticlesController < ApplicationController
	respond_to :html
	before_filter except: [:index, :create] do
		@article = Article.find_or_initialize_by_id params[:id]
	end

	before_filter only: [:create, :update] do # redefine previous_page
		@previous_page = params[:previous_page]
	end

	def index
	end
	
	def show
	end

	def new
		@previous_page = articles_url
	end

	def create
		if (@article = Article.new(params[:article])).save
			redirect_to @article, notice: "Article \"#{@article.title}\" successfully created!"
		else
			render :edit
		end
	end

	def edit
		@previous_page = request.referer or article_url(@article)
	end

	def update
		if @article.update_attributes(params[:article])
			redirect_to @previous_page, notice: "Article \"#{@article.title}\" successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_url, notice: "Article \"#{@article.title}\" successfully purged!" 
	end
end
