class CreateUserRepeatImages < ActiveRecord::Migration
  def change
    create_table :user_repeat_images do |t|
      t.string :image
      t.date :date
      t.references :user
      t.references :historic_image

      t.timestamps
    end
    add_index :user_repeat_images, :user_id
    add_index :user_repeat_images, :historic_image_id
  end
end
