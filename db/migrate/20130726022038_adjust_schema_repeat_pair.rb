class AdjustSchemaRepeatPair < ActiveRecord::Migration
  def up
    remove_column :historic_images, :station_id
    remove_column :repeat_images, :historic_image_id
    rename_column :user_repeat_images, :historic_image_id, :repeat_pair_id
  end

  def down
    add_column :historic_images, :station_id, :integer
    add_column :repeat_images, :historic_image_id, :integer
    rename_column :user_repeat_images, :repeat_pair_id, :historic_image_id
  end
end
