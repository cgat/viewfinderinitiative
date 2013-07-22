class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :description
      t.belongs_to :project

      t.timestamps
    end
    add_index :stations, :project_id
  end
end
