# == Schema Information
#
# Table name: downloads
#
#  id          :integer          not null, primary key
#  title       :string
#  url         :string
#  property_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_downloads_on_property_id  (property_id)
#  index_downloads_on_user_id      (user_id)
#

class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :property

  validates :user_id, :property_id, :title, :url, presence: true
end
