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
  after_create :add_default_details

  # hstore attribute - Property Details - may become very large
  store_accessor :details,
    :list_price, :sqfeet, :beds, :baths, :cars, :garden, :description,
    :matterport_status, :matterport_url, :video_walkthrough_status, :video_walkthrough_url,
    :highlights, :showings, :tag_line,
    :agent_name, :agent_phone, :agent_image_url, :agent_company, :agent_license, :agent_logo_url, :agent_website,
    :neighborhood_name, :neighborhood_description,
    :main_background_image_url, :neighborhood_background_image_url, :contact_background_image_url

  # validates :sqfeet, numericality: true
  # validates :beds, numericality: true
  # validates :baths, numericality: true

  def add_default_details
    # self.list_price = 800000
    # self.sqfeet     = 2000
    # self.beds       = 3
    # self.baths      = 1.5
    # self.cars       = 2
    # self.garden     = "no"
    self.details = { "list_price": 80000, "sqfeet": 2000, "beds": 3, "baths": 1.5, "cars": 2, "garden": "no",
    "description": "Entertain in grand style in the 42' x 21' living room graced by 22' ceilings, a wood-burning fireplace (1 of 3 in the home) surrounded by a floor-to-ceiling plain-sawn cherry wood hearth, and a perfect Freedom Tower view. The top-of-the-line chef's kitchen is clad with premium finishes and fixtures including custom white lacquer cabinets, bluestone counters and professional-grade appliances. Sliding glass doors in the dining area showcase views while opening up the home to even more light and air. Spill out to the awe-inspiring terrace which can be accessed from any room, where a fully-equipped outdoor stainless steel kitchen, sun deck, hot tub and private outdoor shower await.",
    "matterport_status": "no", "video_walkthrough_status": "no",
    "agent_name": "Tony Stark", "agent_phone": "4158675309", "agent_company": "Coldwell Banker", "agent_license": "BRE 1230432",
    "agent_image_url": "http://images4.fanpop.com/image/photos/22500000/i-love-tony-stark-tony-stark-22583608-370-331.jpg",
    "agent_website": "http://www.agent-website.com",
    "neighborhood_name": "Telegraphy Hill",
    "neighborhood_description": "Quintessentially San Francisco, Telegraph Hill overlooks the ceaseless activity along the city’s waterfront. This picturesque neighborhood’s immaculate homes preside over its hillsides at the foot of the iconic Coit Tower—a classic San Francisco structure boasting spectacular views of the bay. Exploring this soaring neighborhood usually requires an uphill hike, but its stunning architecture, hidden staircases, and the chance to glimpse its flock of wild parrots (really!) make the trek worth it.",
    "main_background_image_url": "http://photos.sothebyshomes.com/listing/1600/60acc35aa744acf6c3b898a5eabefba2.jpg",
    "neighborhood_background_image_url": "http://stockarch.com/files/12/06/coit_tower_vista.jpg",
    "contact_background_image_url": "http://cdn.caandesign.com/wp-content/uploads/2015/10/Telegraph-Hill-Residence-by-Feldman-Architecture-06.jpg",
    }
    self.save
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

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end

  def latitude
    GoogleGeocoder.geocode(full_address).latitude
  end

  def longitude
    GoogleGeocoder.geocode(full_address).longitude
  end
end
