class HistoricImage < ActiveRecord::Base
  has_one :repeat_pair
  attr_accessible :date, :image
  mount_uploader :image, BasicImageUploader
end
