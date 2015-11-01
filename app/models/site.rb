# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_sites_on_property_id  (property_id)
#

class Site < ActiveRecord::Base
  belongs_to :property

  validates :property_id, presence: true
end
