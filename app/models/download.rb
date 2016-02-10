# == Schema Information
#
# Table name: downloads
#
#  id            :integer          not null, primary key
#  property_id   :integer
#  user_id       :integer
#  disclosure_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_downloads_on_disclosure_id  (disclosure_id)
#  index_downloads_on_property_id    (property_id)
#  index_downloads_on_user_id        (user_id)
#

class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  belongs_to :disclosure

  validates :user_id, :property_id, :disclosure_id, presence: true
end
