class AddAuthorToArticle < ActiveRecord::Migration
  class Article < ActiveRecord::Base
  end

  def up

    add_column :articles, :author_id, :integer
    
    Article.reset_column_information

    # add all existing authors to table
    Article.find_each do |article|
        article.update_attributes! author_id: Author.find_or_create_by_name(article.author).id
    end

    remove_column :articles, :author
  end
  def down
   
    add_column :articles, :author, :string
    Article.reset_column_information

    Article.find_each do |article|
      article.update_attributes! author: article.author.name
    end

    remove_column :articles, :author_id
  end
end
