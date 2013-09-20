class Station < ActiveRecord::Base
  belongs_to :project
  has_one :repeat_pair
  has_one :historic_image, through: :repeat_pair
  has_one :repeat_image, through: :repeat_pair
  has_many :user_repeat_images, through: :repeat_pair

  attr_accessible :description, :name, :project_id

end
