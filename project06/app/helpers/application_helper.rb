# encoding: UTF-8
module ApplicationHelper
  def title title
    content_for(:title) { "Gamez—#{title}" }
  end

  def subtitle subtitle
    content_for(:subtitle) { subtitle }
  end
end
