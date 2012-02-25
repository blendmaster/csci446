# encoding: UTF-8
module ApplicationHelper
  def title title
    content_for(:title) { "Articl.es—#{title}" }
  end

  def subtitle subtitle
    content_for(:subtitle) { subtitle }
  end

  def icon_to text, icon, link, options
    link_to text, link, options.merge(:class => "#{options[:class]} icon", :'data-icon' => icon)
  end
end
