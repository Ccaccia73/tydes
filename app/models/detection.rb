# == Schema Information
#
# Table name: detections
#
#  id         :integer          not null, primary key
#  user       :integer
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string(255)
#

class Detection < ActiveRecord::Base
	attr_accessible :user, :value, :code

	validates :user, :numericality => { :only_integer => true }
end
