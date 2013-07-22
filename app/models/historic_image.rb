class HistoricImage < ActiveRecord::Base
  belongs_to :station
  attr_accessible :date, :image
end
