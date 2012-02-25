class ArticlesController < ApplicationController
  respond_to :html
  controls :articles

  before_filter only: :edit do
    session[:previous_page] = request.referer || article_url(@article)
  end

  def update # handle special redirect, overriding controls :articles
    if @article.update_attributes(params[:article])
      redirect_to session[:previous_page], notice: "Article \"#{@article.title}\" successfully updated!"
    else
      render :edit
    end
  end
end
