class Station < ActiveRecord::Base
  belongs_to :project
  attr_accessible :description, :name
end
