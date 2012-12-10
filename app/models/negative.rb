# == Schema Information
#
# Table name: negatives
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  dir        :string(255)
#  image      :string(255)
#  x          :integer
#  y          :integer
#  trainings  :integer
#  detections :integer
#  positives  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Negative < ActiveRecord::Base
  attr_accessible :code, :detections, :dir, :image, :name, :positives, :trainings, :x, :y
end
