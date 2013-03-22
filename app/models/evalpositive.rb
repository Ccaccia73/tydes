# == Schema Information
#
# Table name: evalpositives
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  dir        :string(255)
#  image      :string(255)
#  x          :integer
#  y          :integer
#  positives  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Evalpositive < ActiveRecord::Base
  attr_accessible :code, :dir, :image, :name, :positives, :x, :y
end
