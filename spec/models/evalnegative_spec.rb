# == Schema Information
#
# Table name: evalnegatives
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  dir        :string(255)
#  image      :string(255)
#  x          :integer
#  y          :integer
#  detections :integer
#  positives  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Evalnegative do
  pending "add some examples to (or delete) #{__FILE__}"
end
