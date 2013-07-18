# == Schema Information
#
# Table name: clips
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  file              :string(255)
#  shortlink         :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  length            :integer
#  screenshot        :string(255)
#  impressions_count :integer          default(0)
#

require 'spec_helper'

describe Clip do
  pending "add some examples to (or delete) #{__FILE__}"
end
