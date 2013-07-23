class UserRepeatImage < ActiveRecord::Base
  belongs_to :user
  belongs_to :historic_image
  attr_accessible :date, :image, :historic_image_id
  mount_uploader :image, UserRepeatImageUploader
end
