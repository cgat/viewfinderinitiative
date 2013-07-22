class CreateRepeatImages < ActiveRecord::Migration
  def change
    create_table :repeat_images do |t|
      t.string :image
      t.date :date
      t.belongs_to :historic_image

      t.timestamps
    end
    add_index :repeat_images, :historic_image_id
  end
end
