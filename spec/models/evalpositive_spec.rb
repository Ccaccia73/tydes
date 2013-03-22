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

require 'spec_helper'

describe Evalpositive do
  pending "add some examples to (or delete) #{__FILE__}"
end
