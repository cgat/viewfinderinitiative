class RepeatImage < ActiveRecord::Base
  belongs_to :historic_image
  attr_accessible :date, :image
end
