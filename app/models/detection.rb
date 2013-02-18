# == Schema Information
#
# Table name: detections
#
#  id                   :integer          not null, primary key
#  user                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  code                 :string(255)
#  positive_trainingset :text
#  value                :text(255)
#  positive_training    :text
#  fn                   :integer
#  fp                   :integer
#  tn                   :integer
#  tp                   :integer
#  negative_training    :text
#  sight                :integer
#  currId               :integer
#  nickname             :string(255)
#

class Detection < ActiveRecord::Base
	serialize :value, Hash
	serialize :positive_training, Hash
	serialize :negative_training, Hash

	attr_accessible :user, :value, :code, :trainingset, :fp, :fn, :tp, :tn, :sight, :currId, :nickname

	validates :user, :numericality => { :only_integer => true }
	validates :sight, :numericality => { :only_integer => true }
end
