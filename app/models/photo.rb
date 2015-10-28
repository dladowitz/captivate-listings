# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  property_id :integer
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_photos_on_property_id  (property_id)
#

class Photo < ActiveRecord::Base
  belongs_to :property

  validates :position, presence: true
end
