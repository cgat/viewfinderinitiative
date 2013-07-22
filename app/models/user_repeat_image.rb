class UserRepeatImage < ActiveRecord::Base
  belongs_to :user
  belongs_to :historic_image
  attr_accessible :date, :image
end
