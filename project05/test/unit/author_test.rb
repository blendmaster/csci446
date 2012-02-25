require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "no pat Authors" do
    assert Author.new(name: 'Steve').valid?, "Article not by pat is invalid!"
    assert Author.new(name: 'pat').invalid?, "Article by pat is valid!"
  end
end
