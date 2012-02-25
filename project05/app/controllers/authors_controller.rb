class AuthorsController < ApplicationController
  respond_to :html
  before_filter except: [:index, :create] do
    @author = Author.find_or_initialize_by_id params[:id]
  end

  def new
  end

  def create
    if (@author = Author.new(params[:author])).save
      redirect_to @author, notice: "Author \"#{@author.name}\" successfully created!"
    else
      render :edit
    end
  end

  def update
    if @author.update_attributes(params[:author])
      redirect_to @author, notice: "Author \"#{@author.name}\" successfully updated!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @author.destroy
    redirect_to authors_url, notice: "Author \"#{@author.name}\" successfully purged!"
  end

  def index
    @authors = Author.all
  end

  def show
  end
end
