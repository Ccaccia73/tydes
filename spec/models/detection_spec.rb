# == Schema Information
#
# Table name: detections
#
#  id                   :integer          not null, primary key
#  user                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  code                 :string(255)
#  fn                   :integer
#  fp                   :integer
#  tn                   :integer
#  tp                   :integer
#  negative_training    :text
#  positive_trainingset :text
#  value                :text
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
