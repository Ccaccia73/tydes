# == Schema Information
#
# Table name: detections
#
#  id          :integer          not null, primary key
#  user        :integer
#  value       :text(4096)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string(255)
#  trainingset :text(4096)
#  fn          :integer
#  fp          :integer
#  tn          :integer
#  tp          :integer
#

require 'spec_helper'

describe Detection do
	before { @detection = Detection.new(user: 1, value: "y" * 30) }

	subject { @detection }

	it { should respond_to(:user) }
	it { should respond_to(:value) }
	it { should respond_to(:code) }

	describe "when user is not present" do
		before { @detection.user = nil }
		it { should_not be_valid }
	end	



end
