module DetectionsHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def thumb_for(user)
		case user
			when 1 # new
				thumb_url = "/assets/rails.png"
				type = "new"
			when 2 # returning
				thumb_url = "/assets/rails.png"
				type = "returning"
			when 3 # experienced
				thumb_url = "/assets/rails.png"
				type = "experienced"
			else
				thumb_url = "/assets/rails.png"
				type = "unknown"
		end
		image_tag(thumb_url, alt: type, class: "thumb")
	end
end
