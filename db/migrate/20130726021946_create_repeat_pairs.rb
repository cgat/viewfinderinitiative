class CreateRepeatPairs < ActiveRecord::Migration
  def change
    create_table :repeat_pairs do |t|
      t.integer :historic_image_id
      t.integer :repeat_image_id
      t.integer :station_id

      t.timestamps
    end
  end
end
