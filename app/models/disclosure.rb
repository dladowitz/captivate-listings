# == Schema Information
#
# Table name: disclosures
#
#  id          :integer          not null, primary key
#  title       :string
#  url         :string
#  car_form    :string
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_disclosures_on_property_id  (property_id)
#

class Disclosure < ActiveRecord::Base
  belongs_to :property

  validates :url, :title, presence: true

end
