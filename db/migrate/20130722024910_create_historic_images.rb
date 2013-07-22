class CreateHistoricImages < ActiveRecord::Migration
  def change
    create_table :historic_images do |t|
      t.string :image
      t.date :date
      t.belongs_to :station

      t.timestamps
    end
    add_index :historic_images, :station_id
  end
end
