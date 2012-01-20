class ArticlesController < ApplicationController
	respond_to :html
	before_filter except: :index do
		@article = Article.find_or_initialize_by_id params[:id]
	end

	def index
	end
	
	def show
	end

	def edit
		@previous_page = request.referer or article_url(@article)
	end

	def update
		if @article.update_attributes(params[:article])
			redirect_to params[:previous_page], notice: "Article \"#{@article.title}\" successfully updated!"
		else
			@previous_page = params[:previous_page]
			render :edit
		end
	end
end
