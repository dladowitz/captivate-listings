# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  level      :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#

class Subscription < ActiveRecord::Base
  belongs_to :user

  validates :level, presence: true
end
