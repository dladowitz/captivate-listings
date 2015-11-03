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
#  user_id     :integer
#
# Indexes
#
#  index_properties_on_details  (details)
#

class Property < ActiveRecord::Base
  include Geokit::Geocoders

  has_many :photos
  belongs_to :user
  has_one :site

  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  # validates :domain_type, presence: true
  # validates :domain, presence: true

  # after_create :add_domain_suffix

  # hstore attribute - Property Details - may become very large
  store_accessor :details,
    :list_price, :sqfeet, :beds, :baths, :cars, :garden, :description, :matterport_status, :matterport_url, :video_walkthrough_status,
    :video_walkthrough_url, :highlights, :showings, :tag_line, :agent_name, :agent_phone, :agent_image_url,
    :agent_company, :agent_license, :agent_logo_url, :agent_website, :neighborhood_name,
    :neighboorhood_description, :neighboorhood_background_image_url, :contact_background_image_url

  # validates :sqfeet, numericality: true
  # validates :beds, numericality: true
  # validates :baths, numericality: true


  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end

  def latitude
    GoogleGeocoder.geocode(full_address).latitude
  end

  def longitude
    GoogleGeocoder.geocode(full_address).longitude
  end

  # not sure why self is needed here, but domain is nil otherwise
  def add_domain_suffix
    if domain_type && domain_type == "generic"
      self.domain = self.domain + ".captivatelistings.com"
    elsif domain_type == "custom"
      self.domain = "www." + self.domain + ".com"
    else
      self.domain = self.domain + ".something-is-wrong.com"
    end

    self.save
  end
end
