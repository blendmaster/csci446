# -*- encoding : utf-8 -*-
module ApplicationHelper
	def title(page_title) #railscast 30
		content_for(:title) { "Depot — #{page_title}" }
	end
end
