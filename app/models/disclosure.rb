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
  has_many :downloads

  validates :url, :title, presence: true

  def file_type
    extension = self.url.last(4).downcase
    if extension.include? "pdf"
      "pdf"
    elsif extension.include? "docx" or extension.include? "doc"
      "word"
    elsif (extension.include? "ppt" or extension.include? "pptx")
      "powerpoint"
    elsif (extension.include? "xls" or extension.include? "xlsx")
      "excel"
    elsif (extension.include? "zip" or extension.include? "rar")
      "archive"
    elsif (extension.include? "jpg" or extension.include? "jpeg" or extension.include? "png" or extension.include? "gif")
      "image"
    else
      "text"
    end
  end
end
