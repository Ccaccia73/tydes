require 'spec_helper'

describe "Detection pages" do

	subject { page }

	describe "start-up page" do
		before { visit start_path }

		it { should have_selector('h1',    text: 'Start') }
		it { should have_selector('title', text: full_title('Start')) }

		let(:submit) { "Start now!" }

		describe "with invalid information" do
			it "should not create a detection" do
				expect { click_button submit }.not_to change(Detection, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "User",		with: 1
				fill_in "Code",		with: "aabb"
			end

			it "should create a user" do
				expect { click_button submit }.to change(Detection, :count).by(1)
			end
		end
	end
	
	describe "detection show page" do
    	let(:detection) { FactoryGirl.create(:detection) }
    	before { visit detection_path(detection) }

    	it { should have_selector('h1',    text: detection.code) }
    	it { should have_selector('title', text: detection.code) }
  end
end
