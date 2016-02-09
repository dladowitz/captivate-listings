# == Schema Information
#
# Table name: properties
#
#  id            :integer          not null, primary key
#  address       :string
#  city          :string
#  state         :string
#  zip           :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  details       :hstore
#  user_id       :integer
#  enabled       :boolean          default(TRUE), not null
#  custom_domain :string
#
# Indexes
#
#  index_properties_on_details  (details)
#

class Property < ActiveRecord::Base
  include Geokit::Geocoders

  has_many :photos
  has_many :disclosures
  belongs_to :user
  has_one :site

  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }

  after_create :add_default_details
  before_save :normalize_custom_domain, if: :custom_domain_changed?

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
    self.details = { "list_price": 800000, "sqfeet": 2000, "beds": 3, "baths": 2, "cars": 2, "garden": "no",
    "description": "Entertain in grand style in the 42' x 21' living room graced by 22' ceilings, a wood-burning fireplace (1 of 3 in the home) surrounded by a floor-to-ceiling plain-sawn cherry wood hearth, and a perfect Freedom Tower view. The top-of-the-line chef's kitchen is clad with premium finishes and fixtures including custom white lacquer cabinets, bluestone counters and professional-grade appliances. Sliding glass doors in the dining area showcase views while opening up the home to even more light and air. Spill out to the awe-inspiring terrace which can be accessed from any room, where a fully-equipped outdoor stainless steel kitchen, sun deck, hot tub and private outdoor shower await.",
    "matterport_status": "no", "video_walkthrough_status": "no",
    "agent_name": "Tony Stark", "agent_phone": "4158675309", "agent_company": "Coldwell Banker", "agent_license": "BRE 1230432",
    "agent_image_url": "http://www.sprinklesandbooze.com/wp/wp-content/uploads/2013/05/Tony-Stark-1.jpg",
    "agent_website": "http://www.agent-site.com",
    "neighborhood_name": "Telegraphy Hill",
    "neighborhood_description": "Quintessentially San Francisco, Telegraph Hill overlooks the ceaseless activity along the city’s waterfront. This picturesque neighborhood’s immaculate homes preside over its hillsides at the foot of the iconic Coit Tower—a classic San Francisco structure boasting spectacular views of the bay. Exploring this soaring neighborhood usually requires an uphill hike, but its stunning architecture, hidden staircases, and the chance to glimpse its flock of wild parrots (really!) make the trek worth it.",
    "main_background_image_url": "http://photos.sothebyshomes.com/listing/1600/60acc35aa744acf6c3b898a5eabefba2.jpg",
    "neighborhood_background_image_url": "http://stockarch.com/files/12/06/coit_tower_vista.jpg",
    "contact_background_image_url": "http://cdn.caandesign.com/wp-content/uploads/2015/10/Telegraph-Hill-Residence-by-Feldman-Architecture-06.jpg",
    }

    photo_links = ["https://s3-us-west-1.amazonaws.com/captivate-listings-development/property-photos/1/1446407133029-IMG_0226.JPG", "https://s3-us-west-1.amazonaws.com/captivate-listings-development/property-photos/1/1446407141421-IMG_0307.JPG", "https://s3-us-west-1.amazonaws.com/captivate-listings-development/property-photos/1/1446407141427-IMG_0311.JPG", "https://s3-us-west-1.amazonaws.com/captivate-listings-development/property-photos/1/1446407141438-IMG_0325.JPG", "https://s3-us-west-1.amazonaws.com/captivate-listings-development/property-photos/1/1446420210283-IMG_0327.JPG", "https://s3-us-west-1.amazonaws.com/captivate-listings-development/property-photos/1/1446618315678-IMG_0250.JPG?"]

    photo_links.each do |link|
      self.photos.create(url: link)
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

  def disabled?
    !enabled
  end

  def normalize_custom_domain
    # downcasing and removing any trailing forward slashes
    self.custom_domain = self.custom_domain.downcase.chomp('/')

    # add 'http://' is not present
    unless self.custom_domain.index 'http://'
      self.custom_domain = 'http://' + self.custom_domain
    end
    PropertyMailer.custom_domain_change_email(self).deliver
  end
end
