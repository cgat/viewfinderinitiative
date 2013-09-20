class UserRepeatImage < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper #used to format bytes to megabytes

  acts_as_pointsable url_method: "image.url"

  belongs_to :user
  belongs_to :repeat_pair
  has_one :station, through: :repeat_pair
  attr_accessible :date, :image, :image_cache, :repeat_pair_id, :user_id, :repeat_pair_id, :notes

  validates_presence_of :image
  validates_presence_of :date
  validates_presence_of :user_id
  validates_presence_of :repeat_pair_id
  validate :image_resolution_size_less_than_max, :image_file_size_less_than_max
  validate :sufficient_points
  validate :date_not_in_future

  mount_uploader :image, UserRepeatImageUploader

  def aligned?
    width==repeat_image.width && height==repeat_image.height
  end

  def historic_image
    repeat_pair.historic_image
  end

  def repeat_image
    repeat_pair.repeat_image
  end

  ##validation method
  #The long edge of the image must be less than a value set in the environment variables (application.yml)
  def image_resolution_size_less_than_max
    max = ENV['USER_IMAGE_MAX_LENGTH'].to_i
    if image.present? && (height>max || width>max)
      errors.add(:image, "resolution too big! The long edge of the image must be less than #{ENV['USER_IMAGE_MAX_LENGTH']} pixels")
    end
  end

  #scopes
  scope :with_user, ->(some_user){ joins{user}.where{user.id==some_user.id} }

  #The image file size must be less than a value set in the environment variables
  def image_file_size_less_than_max
    max = ENV['USER_IMAGE_MAX_FILE_SIZE'].to_i
    if image.present? && image.size > max
      errors.add(:image, "file size too big! The file size of the image you are trying to upload must be less than #{number_to_human_size ENV['USER_IMAGE_MAX_FILE_SIZE'].to_i}")
    end
  end

  #in order for this image to be alinged with the repeat image, they both must contain the same about of points
  def sufficient_points
    if points.present? && points.length!=repeat_image.points.length
      errors[:base] <<  "Insufficient points. To be able align the image properly, the image must have"+\
                                " the same amount of control points as the base image. "
    end
  end

  def date_not_in_future
    if date.present? && Date.today<date
      errors[:date] << "The date cannot be in the future."
    end
  end


end
