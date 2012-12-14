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

class Detection < ActiveRecord::Base
	serialize :value, Hash
	serialize :trainingset, Array

	attr_accessible :user, :value, :code, :trainingset, :fp, :fn, :tp, :tn

	validates :user, :numericality => { :only_integer => true }
end
