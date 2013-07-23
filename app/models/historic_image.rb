class HistoricImage < ActiveRecord::Base
  belongs_to :station
  attr_accessible :date, :image, :station_id
  mount_uploader :image, BasicImageUploader
end
