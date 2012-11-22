require 'spec_helper'

describe "Static pages" do

	subject{ page }

	let(:base_title) { "TYDES Project" }
	
	describe "Home page" do
		before{ visit root_path }

		it { should have_selector('h1', :text => 'TYDES') }
    	it { should have_selector('title', :text => "TYDES Project" ) }
		it { should_not have_selector('title', :text => '| Home') }
		it { should_not have_content('Spippolo') }
	end

	describe "Help page" do
		before { visit help_path }

		it { should have_selector('h1', :text => 'Help') }
		it { should have_selector('title', :text => "TYDES Project | Help") }
		it { should_not have_content('blah') }
	end

	describe "About page" do
		before { visit about_path }
		
		it { should have_selector('h1', :text => 'About Us') }
		it { should have_selector('title', :text => "#{base_title} | About Us") }
		it { should_not have_content('blah') }
	end

	describe "Contact page" do
		before { visit contact_path }

		it { should have_selector('h1', :text => 'Contact') }
		it { should have_selector('title', :text => "#{base_title} | Contact") }
		it { should_not have_content('blah') }
	end

end
