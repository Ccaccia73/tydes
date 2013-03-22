module DetectionsHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def thumb_for(user)
		case user
			when 1 # new
				thumb_url = "/assets/newbie.gif"
				type = "newbie"
			when 2 # returning
				thumb_url = "/assets/ret.gif"
				type = "returning"
			when 3 # experienced
				thumb_url = "/assets/experienced.gif"
				type = "experienced"
			else
				thumb_url = "/assets/rails.png"
				type = "unknown"
		end
		image_tag(thumb_url, alt: type, title: type ,class: "media-object", width: "64px")
	end
end
