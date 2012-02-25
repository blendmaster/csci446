require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "article fields are present" do
    [:no_title, :no_body].each do |a|
      assert articles(a).invalid?, "article with #{a} is valid!"
    end
  end

  test "edit count increment on change" do
    a = articles(:one)
    a.body = "new post"
    a.save
    assert articles(:one).edits > 1, "Edit count not incremented!"
  end
end
