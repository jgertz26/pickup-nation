class ChangeLattitudeAndLongitude < ActiveRecord::Migration
  def up
    change_column :courts, :latitude, :float, null: false
    change_column :courts, :longitude, :float, null: false
  end

  def down
    change_column :courts, :latitude, :float
    change_column :courts, :longitude, :float
  end
end
