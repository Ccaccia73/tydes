require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "TYDES Project" }
	
	describe "Home page" do

    	it "should have the h1 'TYDES'" do
    		visit '/static_pages/home'
    		page.should have_selector('h1', :text => 'TYDES')
    	end

    	it "should have the title 'Home'" do
    		visit '/static_pages/home'
    		page.should have_selector('title', :text => "#{base_title} | Home")
    	end
	end

	describe "Help page" do

		it "should have the h1 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => 'Help')
		end

		it "should have the title 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('title', :text => "#{base_title} | Help")
    	end

		it "should not contain some blah" do
			visit '/static_pages/help'
			page.should_not have_content('blah')
		end

	end


	describe "About page" do

		it "should have the h1 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('h1', :text => 'About Us')
		end

		it "should have the title 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('title', :text => "#{base_title} | About Us")
    	end

		it "should not contain some blah" do
			visit '/static_pages/about'
			page.should_not have_content('blah')
		end
	end

	describe "Contact page" do

		it "should have the h1 'Contact'" do
			visit '/static_pages/contact'
			page.should have_selector('h1', :text => 'Contact')
		end

		it "should have the title 'Contact'" do
			visit '/static_pages/contact'
			page.should have_selector('title', :text => "#{base_title} | Contact")
		end

		it "should not contain some blah" do
			visit '/static_pages/contact'
			page.should_not have_content('blah')
		end

	end

end
