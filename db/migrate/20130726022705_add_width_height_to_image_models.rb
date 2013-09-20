class AddWidthHeightToImageModels < ActiveRecord::Migration
  def change
    add_column :user_repeat_images, :width, :integer
    add_column :user_repeat_images, :height, :integer
    add_column :historic_images, :width, :integer
    add_column :historic_images, :height, :integer
    add_column :repeat_images, :width, :integer
    add_column :repeat_images, :height, :integer
  end
end
