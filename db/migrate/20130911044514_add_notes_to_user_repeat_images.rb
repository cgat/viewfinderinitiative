class AddNotesToUserRepeatImages < ActiveRecord::Migration
  def change
    add_column :user_repeat_images, :notes, :text
  end
end
