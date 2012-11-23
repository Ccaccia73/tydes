# == Schema Information
#
# Table name: detections
#
#  id         :integer          not null, primary key
#  user       :integer
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Detection < ActiveRecord::Base
	attr_accessible :user, :value

	validates :user, :numericality => { :only_integer => true }
end
