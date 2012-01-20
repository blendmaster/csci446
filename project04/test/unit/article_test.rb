require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
	test "article fields are present" do
		[:no_title, :no_author, :no_body].each do |a|
			assert articles(a).invalid?, "article with #{a} is valid!"
		end
	end

	test "no pat articles" do
		assert articles(:one).valid?, "Article not by pat is invalid!"
		assert articles(:by_pat).invalid?, "Article by pat is valid!"
	end
end
