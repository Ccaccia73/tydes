require 'spec_helper'

describe "Detection pages" do

	subject { page }

	describe "signup page" do
		before { visit start_path }

		it { should have_selector('h1',    text: 'Start') }
		it { should have_selector('title', text: full_title('Start')) }
	end
end
