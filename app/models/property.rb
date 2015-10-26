# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  address     :string
#  city        :string
#  state       :string
#  zip         :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  domain_type :string
#  domain      :string
#  details     :hstore
#

class Property < ActiveRecord::Base
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :domain_type, presence: true
  validates :domain, presence: true

  # store_accessor :details, :list_price, :sqfeet

  after_create :add_domain_suffix


  # not sure why self is needed here, but domain is nil otherwise
  def add_domain_suffix
    if domain_type == "generic"
      self.domain = self.domain + ".captivatelistings.com"
    elsif domain_type == "custom"
      self.domain = "www." + self.domain + ".com"
    else
      self.domain = self.domain + ".something-is-wrong.com"
    end

    self.save
  end
end
