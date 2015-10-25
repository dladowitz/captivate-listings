# == Schema Information
#
# Table name: properties
#
#  id         :integer          not null, primary key
#  address    :string
#  city       :string
#  state      :string
#  zip        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Property < ActiveRecord::Base
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true , length: { is: 2 }
end
