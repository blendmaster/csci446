require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
	def setup
		@article = articles :one
	end

	test "edit article redirected to previous path" do
		[articles_url, article_url(@article)].each do |url|
			post :update, id:@article.id, article: { title: 'title', author: 'author', body: 'body' }, previous_page: url
			assert_redirected_to url, message: "not redirected to #{url}!"
		end
	end
		
end
