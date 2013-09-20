class RepeatImage < ActiveRecord::Base

  acts_as_pointsable url_method: "image.url"

  has_one :repeat_pair
  attr_accessible :date, :image, :width, :height
  mount_uploader :image, BasicImageUploader
end
