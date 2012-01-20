class ArticlesController < ApplicationController
	respond_to :html

	def index
	end
	
	def show
		@article = Article.find params[:id]
	end
end
