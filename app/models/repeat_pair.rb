class RepeatPair < ActiveRecord::Base

  belongs_to :station
  belongs_to :historic_image
  belongs_to :repeat_image
  has_many :user_repeat_images
  has_many :users, through: :user_repeat_images

  attr_accessible :historic_image_id, :repeat_image_id, :station_id

end
