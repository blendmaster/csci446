module ApplicationHelper
	def title(page_title) #railscast 30
		content_for(:title) { "-- #{page_title}" }
	end
end
