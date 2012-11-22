require 'spec_helper'

describe "Static pages" do
	describe "Home page" do
		it "should have content 'TYDES'" do
	 		visit '/static_pages/home'
	 		page.should have_content('TYDES')
		end
	end
end
