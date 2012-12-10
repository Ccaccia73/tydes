# == Schema Information
#
# Table name: detections
#
#  id         :integer          not null, primary key
#  user       :integer
#  value      :text(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string(255)
#

class Detection < ActiveRecord::Base
	serialize :value, Hash

	attr_accessible :user, :value, :code

	validates :user, :numericality => { :only_integer => true }
end
